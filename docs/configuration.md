# Configuration and credentials

All scripts and collections remain historical examples. Review targets and permissions before using account-changing, email-sending, or device-management operations.

## Local scripts

From the repository root, copy `.env.example` to `.env` and enter the required values. Use shell single quotes around values (escape embedded single quotes correctly); this is a shell file, so only load a file you trust.

```sh
set -a
. ./.env
set +a
```

Python reads environment variables directly; Bash checks required secrets before starting the affected operation. Empty secrets are not usable credentials. Install dependencies with `python3 -m pip install -r github_scripts/requirements.txt` or `python3 -m pip install -r bash/zip_n_send/requirements.txt` as needed.

| Variable | Used by |
| --- | --- |
| `GH_API_TOKEN` | All four GitHub Python scripts; token must have access to the target organization and required operations |
| `GH_ORG` | Target organization; private repository searches are restricted to it |
| `GH_TEAM_ID` | `github_scripts/add_team_to_repo.py` |
| `SENDGRID_API_KEY`, `SENDGRID_FROM_EMAIL` | `bash/zip_n_send/sender.py`; use a verified sender |
| `ONBOARDING_INITIAL_PASSWORD` | `GAM/onb.sh`; newly created accounts must change it at first login |
| `OFFBOARDING_PASSWORD`, `OFFBOARDING_WEBHOOK_URL` | `GAM/gam_offb_with_pass.sh` |
| `EAZYBI_REPORT_<report ID>_URL` | Each iframe in the dashboard; seven names appear in `.env.example` |

Offboarding now accepts two arguments; the webhook password comes from the environment instead of the command line:

```sh
bash GAM/gam_offb_with_pass.sh old.user leader.name
```

Other organization-specific domains, account identifiers, paths, and policies remain as historical context. They are not credentials and must be adapted before reuse. Mobileconfig examples do not interpolate shell variables; their existing empty authentication fields remain empty. Runtime credentials required by GAM itself must be configured separately outside this repository.

## GitHub Actions secrets

Create repository secrets under **Settings → Secrets and variables → Actions**. Map each required secret to the same environment variable name in the step that uses it. GitHub secrets do not automatically become local environment variables. `GH_API_TOKEN` deliberately avoids the reserved `GITHUB_` prefix.

For example, inside an existing workflow job after checkout and installing Python dependencies:

```yaml
- name: Report repositories and teams
  env:
    GH_API_TOKEN: ${{ secrets.GH_API_TOKEN }}
    GH_ORG: ${{ vars.GH_ORG }}
  run: python3 github_scripts/repowteams.py
```

`GH_ORG` and `GH_TEAM_ID` can be repository variables; credentials belong in secrets. This is documentation, not an enabled workflow: no administrative scripts run automatically. Configure secrets only for operations you intend to run. Do not print secrets, use shell tracing, or upload rendered private examples as workflow artifacts.

Reference: [GitHub Actions secrets documentation](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets).

## Postman collections

Import the collections directly into Postman and define the named `{{UPPERCASE_VARIABLES}}` in a private Postman environment. Authentication fields use service-specific names. Existing lowercase collection variables are retained for compatibility. For example, Miro authentication uses `MIRO_SCIM_TOKEN`.

Alternatively, render a private copy from environment variables (including variables mapped from GitHub secrets):

```sh
python3 tools/render_examples.py \
  'postman_examples/Miro SCIM.postman_collection.json' \
  local/miro.postman_collection.json
```

List the required credential variables for a collection without displaying any values:

```sh
rg -o '\{\{[A-Z][A-Z0-9_]*\}\}' postman_examples/*.json
```

The renderer preserves JSON types and escapes secret values safely. It fails if a required variable is missing. `X` and `api_token` basic-auth password literals are protocol conventions, not credentials. Inputs and example requests are retained, including unfinished historical examples.

## Private dashboard

The HTML is a template; set all seven `EAZYBI_REPORT_<ID>_URL` variables to full HTTPS embed URLs and render it:

```sh
python3 tools/render_examples.py eazyBi_reports/dashboard.html local/dashboard.html
```

Open the generated file locally. The renderer escapes HTML attributes and refuses non-HTTPS URLs. Embedded report credentials are necessarily visible to anyone who can read the rendered page. Keep the generated page private; never publish it as a portfolio page. GitHub secrets cannot remain secret inside a publicly served static page.

Rendered files are restricted to the ignored `local/` directory, created with owner-only permissions, and never overwrite existing files. Choose a new filename for another render.

## Existing history

Removing credentials from working files does not remove them from earlier commits. Revoke or rotate previously embedded GitHub, SendGrid, webhook, onboarding, and report credentials before publication. The portfolio was published as a cleaned snapshot without importing the original internal repository history. No remote secrets were created. `.DS_Store` files are excluded from the portfolio snapshot.
