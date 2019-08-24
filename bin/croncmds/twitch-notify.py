#!/bin/python

import json
import requests
import subprocess
import sys

def sendmessage(message):
    subprocess.Popen(['notify-send', "Twitch", message])

# Settings
user_id = "your-user-id"
headers = { 'Client-ID': "your-client-id", }

if user_id is "your-user-id" or headers["Client-ID"] is "your-client-id":
    sys.exit("ERROR: Set user_id and client_id")

# Let's fetch and parse data from twitch
r = requests.get("https://api.twitch.tv/helix/users/follows?from_id=%s" % user_id, headers=headers)
raw_data = r.json()

# Get followed channels
followed_channels = []
for channel in raw_data["data"]:
    followed_channels.append(channel["to_name"])

# Get Stream info
r = requests.get('https://api.twitch.tv/helix/streams?user_login=%s&user_login%s' % (followed_channels[0], '&user_login='.join(followed_channels[1:])), headers=headers)
live_streams = r.json()

game_cache = {}
output = set()
for stream in live_streams["data"]:
    channel_name = stream["user_name"]
    game_id = int(stream["game_id"])

    # Receiving gamename with hashmap as cache
    channel_game = ""
    if game_id in game_cache:
        channel_game = game_cache.get(game_id)
    else:
        rg = requests.get('https://api.twitch.tv/helix/games?id=%d' % game_id, headers=headers)
        game_json = rg.json()
        channel_game = game_json["data"][0]["name"]
        game_cache[game_id] = channel_game

    # Build output string
    output.add("<b>" + channel_name + "</b> is <b>LIVE</b> playing <b>" + channel_game + "</b>")

# Load oldData
old_data = set()
try:
    with open("/tmp/twitch-streams.txt", "r") as f:
        for line in f:
            if line is not '\n' or '':
                old_data.add(line.replace('\n', ''))
except FileNotFoundError:
    print('File not created yet')

# Return new livestreams
went_live = output - old_data
went_offline = old_data - output

if len(went_live) != 0 or len(went_offline) != 0:
    # Send notifications
    for line in iter(went_live):
        sendmessage(line)
    for line in iter(went_offline):
        sendmessage(line.split("LIVE", 1)[0] + "NO LONGER LIVE")

    # Update file
    with open("/tmp/twitch-streams.txt", "w") as f:
        for item in output:
            f.write("%s\n" % item)
