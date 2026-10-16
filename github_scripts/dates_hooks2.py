import os

from github import Github

for name in ['GH_API_TOKEN', 'GH_ORG']:
    if not os.environ.get(name):
        raise SystemExit(f"Missing environment variable: {name}")

git = Github(os.environ["GH_API_TOKEN"])
org = git.get_organization(os.environ["GH_ORG"])
private_repos = git.search_repositories(query=f"org:{os.environ['GH_ORG']} is:private sort:updated")

f = open("list.txt", "w")

for repo in private_repos:
    try:
        sha = repo.get_commit("master").sha
        commit = repo.get_commit(sha=sha)
    except:
        print(repo.name, "skipped_due_to_commit_error")
    try:
        hooks = repo.get_hooks()
        for hook in hooks:
            print(repo.name,commit.commit.committer.date,hook.config['url'])
    except:
        print(repo.name, commit.commit.committer.date,"error_webhook")
