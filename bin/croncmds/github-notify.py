#!/bin/python

import sys
import requests
from pathlib import Path
import configparser
import notify2
import dbus


class Notifycation():
    def __init__(self):
        try:
            notify2.init("Github-notify")
            self.notify_off = False
        except dbus.exceptions.DBusException:
            print("Notification do not work")
            self.notify_off = True

    def send(self, gh_type, repo, title, icon=""):
        l_owner = repo.split("/")[0]
        l_repo = repo.split("/")[1]
        content = "{}/<b>{}</b>\n{}".format(l_owner, l_repo, title)
        if not self.notify_off:
            notify2.Notification(gh_type, content, icon).show()

# Settings
# Read in config file
# Location: ~/.config/github-notify.conf
# Config file structure
#
# [DEFAULT]
# token = <token>
#


notify = Notifycation()
HOME = str(Path.home())

config = configparser.ConfigParser()
config.read(HOME + "/.config/github-notify.conf")

try:
    token = config['DEFAULT']['token']
    headers = {"Authorization": "token " + token}
except Exception:
    print("Config file not found")
    sys.exit()

url = "https://api.github.com/notifications"
data = requests.get(url, headers=headers).json()

for element in data:
    gh_type = element["subject"]["type"]
    repo = element["repository"]["full_name"]
    title = element["subject"]["title"]
    notify.send(gh_type, repo, title)
