#!/bin/sh

g810-led -a ff0000 &
pgrep dunst >/dev/null || dunst &
# pgrep compton >/dev/null || compton &
fixdisplay &
feh --bg-fill ~/img/2560x1440.jpg --bg-fill ~/img/1920x1080.jpg --no-fehbg
pgrep clipmenud >/dev/null|| clipmenud &
pgrep lxpolkit >/dev/null || lxpolkit &

calsync >/dev/null &
newsup >/dev/null &
mailsync >/dev/null &

dwmbar &
pgrep conky >/dev/null || conky &

pgrep calnotify.py >/dev/null || calnotify.py 30 &
github-notify.py start

pgrep nextcloud >/dev/null || nextcloud --background &

xset r rate 300 50
setxkbmap -option caps:escape
