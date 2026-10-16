import os

from github import Github

for name in ['GH_API_TOKEN', 'GH_ORG', 'GH_TEAM_ID']:
    if not os.environ.get(name):
        raise SystemExit(f"Missing environment variable: {name}")

git = Github(os.environ["GH_API_TOKEN"])
org = git.get_organization(os.environ["GH_ORG"])

repos = git.search_repositories(query=f"org:{os.environ['GH_ORG']}")
team = org.get_team(int(os.environ["GH_TEAM_ID"]))  #id

'''
:id taken from below
curl -H "Authorization: token <paste your github token here>" https://api.github.com/orgs/netguru/teams/netguru-read_tmp

a nizej, na pale dodaje do kazdego repo team netguru-read_tmp

'''


for repo in repos:
    try:
        team.add_to_repos(repo)
    except:
        pass
