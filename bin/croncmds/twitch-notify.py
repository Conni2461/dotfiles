#!/bin/python
'''
Script to send notification of new livestreams
'''

import sys
import math
from pathlib import Path
import configparser
import requests
import notify2

def sendmessage(message):
    '''
    Send notification with notify-send
    Uses notify2 package
    '''
    if not notify_off:
        notify2.Notification("Twitch", message).show()

def log(message):
    '''
    Log message to stderr and exits script
    '''
    print(message, file=sys.stderr)
    sys.exit()

def getNewOAuthToken(client):
    '''
    Prints message on how to receive a new OAuth token.
    '''
    print()
    print("To get a custom OAuth Token run:")
    print("curl " + 'https://id.twitch.tv/oauth2/authorize?response_type=token&client_id={}&redirect_uri=http://localhost'.format(client) + " > output.html")
    print("Open the html file with your browser and log into twitch. The next page that opens contains the token.")
    print("Paste the new token in the config file.")


HOME = str(Path.home())
configFilePath = HOME + "/.config/twitch-notify.conf"

try:
    configFile = open(configFilePath)
except Exception:
    log("""
Config file not found.

# Location: ~/.config/twitch-notify.conf
# Config file structure
#
# [DEFAULT]
# User-ID = <user-id>
# Client-ID = <Client-ID>
# Client-Secret = <Client-Secret>
# Access-token = <OAuth-token>
        """)

config = configparser.ConfigParser()
config.read_file(configFile)

try:
    defaultConfig = config["DEFAULT"]
except Exception:
    log("Could not find DEFAULT Field")

user_id = defaultConfig.get("User-ID")
client = defaultConfig.get("Client-ID")
token = defaultConfig.get("Access-token")

if user_id == None:
    log("User id not found")

if client == None:
    log("Client id not found")

if token == None:
    print("No token found.")
    getNewOAuthToken(client)
    sys.exit()

headers_val = { 'Authorization': 'OAuth {}'.format(token) }
headers = { 'Client-ID': '{}'.format(client), 'Authorization': 'Bearer {}'.format(token) }
val = requests.get('https://id.twitch.tv/oauth2/validate', headers=headers_val).json()
print(val)
exp_in = int(val["expires_in"])
if exp_in == 0:
    print("Your token is expired.")
    getNewOAuthToken(client)
    sys.exit()

filelocation = HOME + "/.local/share/twitch-streams.txt"
notify_off = False
apipage = "https://api.twitch.tv/helix/"

# Init notify2
try:
    notify2.init("Twitch-notify")
except Exception:
    print("Notification do not work")
    notify_off = True

# First follow fetch. Will fetch 20
followed = []
followrequest = apipage + "users/follows?from_id=%s" % user_id
data = requests.get(followrequest, headers=headers).json()
print(data)

# Collect all follows.
# So this will send requests until there are all followers fetched
while len(data["data"]) != 0:
    # Get followed channels
    for channel in data["data"]:
        followed.append(channel["to_id"])

    nextV = data["pagination"]["cursor"]
    followr = apipage + "users/follows?from_id=%s&after=%s" % (user_id, nextV)
    data = requests.get(followr, headers=headers).json()

game_cache = {}
output = set()

for j in range(math.ceil(len(followed) / 100)):
    # Get Stream info
    streamrequest = apipage + "streams?user_id=" + followed[100 * j]
    for i in range((100 * j) + 1, (j + 1) * 100):
        if i >= len(followed):
            break
        streamrequest += '&user_id=%s' % followed[i]

    streams = requests.get(streamrequest, headers=headers).json()

    for stream in streams["data"]:
        channel_name = stream["user_name"]
        game_id = -1
        if stream["game_id"] != "":
            game_id = int(stream["game_id"])

        # Receiving gamename with hashmap as cache
        channel_game = ""
        if game_id in game_cache:
            channel_game = game_cache.get(game_id)
        else:
            if game_id == -1:
                channel_game = "\"unknown game\""
                game_cache[game_id] = channel_game
            else:
                gamerequest = apipage + "games?id=%d" % game_id
                rg = requests.get(gamerequest, headers=headers)
                game_json = rg.json()
                channel_game = game_json["data"][0]["name"]
                game_cache[game_id] = channel_game

        # Build output string
        result = "<b>" + channel_name + "</b>"
        result += " is <b>LIVE</b> playing <b>" + channel_game + "</b>"
        output.add(result)

# Load oldData
prev_output = set()
try:
    with open(filelocation, "r") as f:
        for line in f:
            if line != '\n' or line != '':
                prev_output.add(line.replace('\n', ''))
except Exception:
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
