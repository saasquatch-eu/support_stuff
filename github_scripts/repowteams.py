import os

from github import Github

for name in ['GH_API_TOKEN', 'GH_ORG']:
    if not os.environ.get(name):
        raise SystemExit(f"Missing environment variable: {name}")

git = Github(os.environ["GH_API_TOKEN"])
org = git.get_organization(os.environ["GH_ORG"])

repos = git.search_repositories(query=f"org:{os.environ['GH_ORG']}")
#3293236

for repo in repos:
    teams_list=[]
    repo_teams = repo.get_teams()
    for team in repo_teams:
        teams_list.append(team.name)
    print(repo.name,*reversed(teams_list),sep=',')
