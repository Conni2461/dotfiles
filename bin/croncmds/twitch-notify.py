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
    if not NOTIFY_OFF:
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

CONFIG = configparser.ConfigParser()
CONFIG.read(HOME + "/.config/twitch-notify.conf")

try:
    USER_ID = CONFIG['DEFAULT']['User-ID']
    TOKEN = CONFIG['DEFAULT']['Client-ID']
    HEADERS = {'Client-ID': '%s' % TOKEN}
except KeyError:
    print("Config file not found")
    sys.exit()

SAVEFILE = HOME +"/.local/share/twitch-streams.txt"
NOTIFY_OFF = False

# Init notify2
try:
    notify2.init("Twitch-notify")
except dbus.exceptions.DBusException:
    print("Notification do not work")
    NOTIFY_OFF = True


# Let's fetch and parse data from twitch
DATA = requests.get("https://api.twitch.tv/helix/users/follows?from_id=%s" % \
        USER_ID, headers=HEADERS).json()

# Get followed channels
FOLLOWED = []
for channel in DATA["data"]:
    FOLLOWED.append(channel["to_name"])

# Get Stream info
STREAMS = requests.get('https://api.twitch.tv/helix/streams?user_login=%s&user_login=%s' % \
        (FOLLOWED[0], '&user_login='.join(FOLLOWED[1:])), headers=HEADERS).json()

GAME_CACHE = {}
OUTPUT = set()
for stream in STREAMS["data"]:
    channel_name = stream["user_name"]
    game_id = int(stream["game_id"])

    # Receiving gamename with hashmap as cache
    channel_game = ""
    if game_id in GAME_CACHE:
        channel_game = GAME_CACHE.get(game_id)
    else:
        rg = requests.get('https://api.twitch.tv/helix/games?id=%d' % game_id, headers=HEADERS)
        game_json = rg.json()
        channel_game = game_json["data"][0]["name"]
        GAME_CACHE[game_id] = channel_game

    # Build output string
    OUTPUT.add("<b>" + channel_name + "</b> is <b>LIVE</b> playing <b>" + channel_game + "</b>")

# Load oldData
OLD_OUTPUT = set()
try:
    with open(SAVEFILE, "r") as f:
        for line in f:
            if line != '\n' or line != '':
                OLD_OUTPUT.add(line.replace('\n', ''))
except FileNotFoundError:
    print('File not created yet')

# Return new livestreams
WENT_LIVE = OUTPUT - OLD_OUTPUT
WENT_OFFLINE = OLD_OUTPUT - OUTPUT

if WENT_LIVE or WENT_OFFLINE:
    # Send notifications
    for line in iter(WENT_LIVE):
        sendmessage(line)
    for line in iter(WENT_OFFLINE):
        sendmessage(line.split("LIVE", 1)[0] + "NO LONGER LIVE")

    # Update file
    with open(SAVEFILE, "w") as f:
        for item in OUTPUT:
            f.write("%s\n" % item)
