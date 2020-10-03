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
import dbus


class Notifycation():
    def __init__(self):
        try:
            notify2.init("Twitch-notify")
            self.notify_off = False
        except dbus.exceptions.DBusException:
            print("Notification do not work")
            self.notify_off = True

    def send(self, text, icon=""):
        if not self.notify_off:
            notify2.Notification("Twitch", text, icon).show()


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
    print("curl 'https://id.twitch.tv/oauth2/authorize?response_type=token&client_id={}&redirect_uri=http://localhost' > output.html".format(client))
    print("Open the html file with your browser and log into twitch. The next page that opens contains the token.")
    print("Paste the new token in the config file.")


notify = Notifycation()
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

if user_id is None:
    log("User id not found")

if client is None:
    log("Client id not found")

if token is None:
    print("No token found.")
    getNewOAuthToken(client)
    sys.exit()

headers_val = {'Authorization': 'OAuth {}'.format(token)}
headers = {
        'Client-ID': '{}'.format(client),
        'Authorization': 'Bearer {}'.format(token)}
val_res = requests.get('https://id.twitch.tv/oauth2/validate',
                       headers=headers_val)
print(val_res.json())
if val_res.status_code == 401:
    print("Your token is expired.")
    getNewOAuthToken(client)
    sys.exit()

filelocation = HOME + "/.local/share/twitch-streams.txt"
apipage = "https://api.twitch.tv/helix/"

# Emulates a do while
# First follow fetch. Will fetch 20
followed = []
followrequest = "%susers/follows?from_id=%s" % (apipage, user_id)
data = requests.get(followrequest, headers=headers).json()
for channel in data["data"]:
    followed.append(channel["to_id"])

# Collect all follows.
# So we will send requests until all followers are fetched
while "cursor" in data["pagination"].keys():
    nextV = data["pagination"]["cursor"]
    data = requests.get("%s&after=%s" % (followrequest, nextV),
                        headers=headers).json()
    for channel in data["data"]:
        followed.append(channel["to_id"])

game_cache = {}
output = {}

for j in range(math.ceil(len(followed) / 100)):
    # Get Stream info
    streamrequest = "%sstreams?user_id=%s" % (apipage, followed[100 * j])
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
                gamerequest = "%sgames?id=%d" % (apipage, game_id)
                rg = requests.get(gamerequest, headers=headers)
                game_json = rg.json()
                channel_game = game_json["data"][0]["name"]
                game_cache[game_id] = channel_game

        output[channel_name] = channel_game

# Load oldData
prev_output = {}
try:
    with open(filelocation, "r") as f:
        for line in f:
            if line != '\n' or line != '':
                c = line.replace('\n', '').split(';')[0]
                g = line.replace('\n', '').split(';')[1]
                prev_output[c] = g
except Exception:
    print('File not created yet')

live_channels = set([k for k in output])
prev_live = set([k for k in prev_output])

went_live = live_channels - prev_live
went_offline = prev_live - live_channels

# Search for game change
changed_game = set()
for k, v in output.items():
    if prev_output.get(k, None) not in [v, None]:
        changed_game.add(k)

if went_live or went_offline or changed_game:
    # Send notifications
    for line in iter(went_live):
        notify.send("<b>{}</b> is <b>LIVE</b> playing <b>{}</b>"
                    .format(line, output[line]))
    for line in iter(went_offline):
        notify.send("<b>{}</b> is <b>NO LONGER LIVE</b>".format(line))
    for line in iter(changed_game):
        notify.send("<b>{}</b> changed game and is now playing <b>{}</b>"
                    .format(line, output[line]))

    # Update file
    with open(filelocation, "w") as f:
        for k, v in output.items():
            f.write("{};{}\n".format(k, v))
