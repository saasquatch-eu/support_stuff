# IT operations and automation examples

A collection of scripts, API examples, configuration profiles, and training material from previous IT operations projects. It documents work across SaaS administration, Google Workspace, GitHub, and macOS device management.

These are historical examples with varying levels of completeness. Organization-specific configuration remains visible as context; adapt it before reuse. Scripts may change accounts, permissions, files, or device state.

## Explore the collection

| Area | Examples |
| --- | --- |
| [Google Workspace automation](GAM/) | GAM onboarding, offboarding, file and group administration |
| [GitHub automation](github_scripts/) | Repository/team reporting, webhook inspection, and team access assignment |
| [macOS scripts](macos_scripts/) | User dialogs, restart reminders, application remediation, and installation examples |
| [MDM profiles](mdm_stuff/profiles/) | Configuration payloads for managed macOS applications and services |
| [API and SCIM examples](postman_examples/) | Postman collections for SaaS administration and provisioning |
| [File delivery](bash/zip_n_send/) | Shell orchestration and a Python SendGrid attachment sender |
| [Reporting](eazyBi_reports/) | A template for embedding multiple eazyBI reports in one dashboard |
| [Git workshop](github_workshop/instructions.md) | Introductory Git and GitHub training material |

## Configuration

Start with [configuration and secrets](docs/configuration.md) and [.env.example](.env.example). Credentials are supplied through environment variables; Postman uses named private environment variables. A renderer creates private copies of the dashboard and collections beneath ignored `local/`.

GitHub Actions secrets must be explicitly mapped to environment variables in the workflow step. No administrative workflow is enabled in this repository.
