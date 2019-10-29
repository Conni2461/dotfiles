#!/bin/python

import sys
import os
from pathlib import Path
import requests
import configparser

def sendmail(header, content):
    os.system("echo %s | mail -s '%s' %s" % (content, header, receiver))

def getCommitMessage(sha):
    return data["commit"]["message"]

def getCommitDiff(sha):
    output = ""
    for file in data["files"]:
        output = "%s\n" % file["patch"]
    return output

home = str(Path.home())

# Read in file from first argument
# Should enter the full file path
# Config file location: $HOME/.config/commit-notify.conf
# Config file structure
#
# [DEFAULT]
# Token = <token>
# Mantainer = <github user>
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

savefile = home + "/.local/share/%s-%s-commits-%s.txt" % (mantainer, repo, branch)
headers = { 'Authorization': 'token %s' % token }
data = requests.get("https://api.github.com/repos/%s/%s/commits" % (mantainer, repo), headers=headers).json()

output = set()
for commit in data:
    output.add(commit["sha"])

old_data = set()
try:
    with open(savefile, "r") as f:
        for line in f:
            if line != '\n' or line != '':
                old_data.add(line.replace('\n', ''))
except FileNotFoundError:
    print('File not created yet')

new_commits = output - old_data

if len(new_commits) != 0 or len(new_commits) != 0:
    # Send mail
    for sha in iter(new_commits):
        data = requests.get("https://api.github.com/repos/%s/%s/commits/%s" % (mantainer, repo, sha), headers=headers).json()
        message = getCommitMessage(data)
        diff = getCommitDiff(data)

        content = "%s\n\n%s" % (message, diff)
        sendmail("New commit to %s/%s" %(mantainer, repo), content)

    # Update file
    with open(savefile, "w") as f:
        for item in output:
            f.write("%s\n" % item)
