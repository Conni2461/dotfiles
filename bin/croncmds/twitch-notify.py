#!/bin/python
'''
Script to send notification of new livestreams
'''

import sys
from pathlib import Path
import configparser
import requests
import notify2
import dbus


def sendmessage(message):
    '''
    Send notification with notify-send
    Uses notify2 package
    '''
    if not notify_off:
        notify2.Notification("Twitch", message).show()

# Settings
# Read in config file
# Location: ~/.config/twitch-notify.conf
# Config file structure
#
# [DEFAULT]
# User-ID = <user-id>
# Client-ID = <Client-ID>
#


HOME = str(Path.home())

config = configparser.ConfigParser()
config.read(HOME + "/.config/twitch-notify.conf")

try:
    user_id = config['DEFAULT']['User-ID']
    token = config['DEFAULT']['Client-ID']
    headers = {'Client-ID': '%s' % token}
except KeyError:
    print("Config file not found")
    sys.exit()

filelocation = HOME + "/.local/share/twitch-streams.txt"
notify_off = False
apipage = "https://api.twitch.tv/helix/"

# Init notify2
try:
    notify2.init("Twitch-notify")
except dbus.exceptions.DBusException:
    print("Notification do not work")
    notify_off = True

# First follow fetch. Will fetch 20
followed = []
followrequest = apipage + "users/follows?from_id=%s" % user_id
data = requests.get(followrequest, headers=headers).json()

# Collect all follows.
# So this will send requests until there are all followers fetched
while len(data["data"]) != 0:
    # Get followed channels
    for channel in data["data"]:
        followed.append(channel["to_id"])

    next = data["pagination"]["cursor"]
    followr = apipage + "users/follows?from_id=%s&after=%s" % (user_id, next)
    data = requests.get(followr, headers=headers).json()

# Get Stream info
streamrequest = apipage + "streams?user_id=" + followed[0]
for i in range(1, len(followed)):
    streamrequest += '&user_id=%s' % followed[i]

streams = requests.get(streamrequest, headers=headers).json()

game_cache = {}
output = set()
for stream in streams["data"]:
    channel_name = stream["user_name"]
    game_id = int(stream["game_id"])

    # Receiving gamename with hashmap as cache
    channel_game = ""
    if game_id in game_cache:
        channel_game = game_cache.get(game_id)
    else:
        rg = requests.get(apipage + "games?id=%d" % game_id, headers=headers)
        game_json = rg.json()
        channel_game = game_json["data"][0]["name"]
        game_cache[game_id] = channel_game

    # Build output string
    output.add("<b>" + channel_name + "</b> is <b>LIVE</b> playing <b>" + channel_game + "</b>")

# Load oldData
prev_output = set()
try:
    with open(filelocation, "r") as f:
        for line in f:
            if line != '\n' or line != '':
                prev_output.add(line.replace('\n', ''))
except FileNotFoundError:
    print('File not created yet')

# Return new livestreams
went_live = output - prev_output
went_offline = prev_output - output

if went_live or went_offline:
    # Send notifications
    for line in iter(went_live):
        sendmessage(line)
    for line in iter(went_offline):
        sendmessage(line.split("LIVE", 1)[0] + "NO LONGER LIVE")

    # Update file
    with open(filelocation, "w") as f:
        for item in output:
            f.write("%s\n" % item)
