import os

from github import Github

for name in ['GH_API_TOKEN', 'GH_ORG']:
    if not os.environ.get(name):
        raise SystemExit(f"Missing environment variable: {name}")

git = Github(os.environ["GH_API_TOKEN"])
org = git.get_organization(os.environ["GH_ORG"])
private_repos = git.search_repositories(query=f"org:{os.environ['GH_ORG']} is:private sort:updated")

for repo in private_repos:
    try:
        hooks = repo.get_hooks()
        for hook in hooks:
            print(repo.name,hook.config['url'])
    except:
        print(repo.name,"nydyrydy")
