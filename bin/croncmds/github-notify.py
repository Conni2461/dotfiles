#!/bin/python

import requests
import notify2
from pathlib import Path
import configparser

def sendmessage(gh_type, repo, title):
    '''
    Send notification with notify-send
    Uses notify2 package
    '''
    l_owner = repo.split("/")[0]
    l_repo = repo.split("/")[1]
    content = "{}/<b>{}</b>\n{}".format(l_owner, l_repo, title)
    if not notify_off:
        notify2.Notification(gh_type, content).show()

# Settings
# Read in config file
# Location: ~/.config/github-notify.conf
# Config file structure
#
# [DEFAULT]
# token = <token>
#

notify_off = False

HOME = str(Path.home())

config = configparser.ConfigParser()
config.read(HOME + "/.config/github-notify.conf")

try:
    token = config['DEFAULT']['token']
    headers = {"Authorization": "token " + token}
except Exception:
    print("Config file not found")
    sys.exit()

# Init notify2
try:
    notify2.init("Github-notify")
except Exception:
    print("Notification do not work")
    notify_off = True

url = "https://api.github.com/notifications"
data = requests.get(url, headers=headers).json()

for element in data:
    gh_type = element["subject"]["type"]
    repo = element["repository"]["full_name"]
    title = element["subject"]["title"]
    sendmessage(gh_type, repo, title)
