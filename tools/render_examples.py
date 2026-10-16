"""Render dashboard or Postman templates from environment variables, offline."""
import argparse
import html
import json
import os
from pathlib import Path
import re
from urllib.parse import urlsplit


def render(source):
    text = source.read_text()
    if source.suffix == '.json':
        data = json.loads(text)

        def substitute(value):
            if isinstance(value, str):
                return re.sub(r'\{\{([A-Z][A-Z0-9_]*)\}\}',
                              lambda match: required(match[1]), value)
            if isinstance(value, list):
                return [substitute(item) for item in value]
            if isinstance(value, dict):
                return {key: substitute(item) for key, item in value.items()}
            return value

        return json.dumps(substitute(data), indent=2, ensure_ascii=False) + '\n'
    if source.suffix == '.html':
        def url(match):
            value = required(match[1])
            parsed = urlsplit(value)
            if parsed.scheme != 'https' or not parsed.hostname or parsed.username or parsed.password:
                raise ValueError(f'{match[1]} must be an HTTPS URL without user information')
            return html.escape(value, quote=True)
        return re.sub(r'\$\{([A-Z][A-Z0-9_]*)\}', url, text)
    raise ValueError('Supported templates: .json and .html')


def required(name):
    value = os.environ.get(name)
    if not value:
        raise ValueError(f'Missing environment variable: {name}')
    return value


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path, help='New file beneath ignored local/ directory')
    args = parser.parse_args()
    local = Path('local').resolve()
    target = args.output.resolve()
    if local not in target.parents:
        parser.error('Output must be beneath local/; rendered files contain secrets')
    try:
        result = render(args.source)
        target.parent.mkdir(parents=True, exist_ok=True)
        # Exclusive creation prevents accidentally replacing a tracked template.
        fd = os.open(target, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
        with os.fdopen(fd, 'w') as output:
            output.write(result)
    except (ValueError, OSError) as error:
        parser.exit(1, f'{error}\n')


if __name__ == '__main__':
    main()
