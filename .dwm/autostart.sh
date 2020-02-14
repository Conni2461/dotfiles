#!/bin/sh

g810-led -a ff0000 &
pgrep dunst >/dev/null || dunst &
pgrep compton >/dev/null || compton &
fixdisplay &
feh --bg-fill ~/img/2560x1440.jpg --bg-fill ~/img/1920x1080.jpg
pgrep clipmenud >/dev/null|| clipmenud &

calsync >/dev/null &
newsup >/dev/null &
mailsync >/dev/null &

dwmbar &
pgrep conky >/dev/null || conky &

pgrep calnotify >/dev/null || calnotify 30 &

pgrep nextcloud >/dev/null || nextcloud --background &
