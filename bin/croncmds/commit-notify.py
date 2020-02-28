#!/bin/python

import os
from pathlib import Path
import requests
import configparser


def sendmail(header, content, sha):
    with open("/tmp/%s.txt" % sha, "w") as f:
        f.write(content)

    os.system("cat /tmp/%s.txt | mail -s '%s' %s" % (sha, header, receiver))
    os.remove("/tmp/%s.txt" % sha)


def getCommitMessage(sha):
    return data["commit"]["message"]


def getCommitDiff(sha):
    output = ""
    for file in data["files"]:
        output += file["filename"] + "\n"

        output += "Additions: " + str(file["additions"])
        output += " Delections: " + str(file["deletions"]) + "\n"

        output += file["blob_url"] + "\n"
        output += file["patch"] + "\n\n----------\n\n"
    return output


home = str(Path.home())

# Read in file from first argument
# Should enter the full file path
# Config file location: $HOME/.config/commit-notify.conf
# Config file structure
#
# [DEFAULT]
# Token = <token>
# Mantainer = <github mantainer>
# Repository = <github repo>
# Branch = <branch to track>
# Receiver = <email which is selected to receive mails>
#

config = configparser.ConfigParser()
config.read(home + "/.config/commit-notify.conf")

token = config['DEFAULT']['Token']

mantainer = config['DEFAULT']['Mantainer']
repo = config['DEFAULT']['Repository']
branch = config['DEFAULT']['Branch']

receiver = config['DEFAULT']['Receiver']

sf = home + "/.local/share/%s-%s-commits-%s.txt" % (mantainer, repo, branch)
headers = {"Authorization": "token " + token}
url = "https://api.github.com/repos/%s/%s/" % (mantainer, repo)
data = requests.get(url + "commits", headers=headers).json()

output = set()
for commit in data:
    output.add(commit["sha"])

old_data = set()
try:
    with open(sf, "r") as f:
        for line in f:
            if line != '\n' or line != '':
                old_data.add(line.replace('\n', ''))
except Exception:
    print('File not created yet')

new_commits = output - old_data

if len(new_commits) != 0 or len(new_commits) != 0:
    # Send mail
    for sha in iter(new_commits):
        data = requests.get(url + "commits/" + sha, headers=headers).json()
        message = getCommitMessage(data)
        diff = getCommitDiff(data)

        content = "%s\n\n%s" % (message, diff)
        sendmail("New commit to %s/%s" %(mantainer, repo), content, sha)

    # Update file
    with open(sf, "w") as f:
        for item in output:
            f.write("%s\n" % item)
