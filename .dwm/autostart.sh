#!/bin/sh

g810-led -a ff0000 &
pgrep dunst >/dev/null || dunst &
pgrep compton >/dev/null || compton &
fixdisplay &
nitrogen --restore &
pgrep clipmenud >/dev/null|| clipmenud &

syncshared >/dev/null &
newsup >/dev/null &
mailsync >/dev/null &

dwmbar &
pgrep conky >/dev/null || conky &

pgrep calnotify >/dev/null || calnotify 30 &

pgrep nextcloud >/dev/null || nextcloud &
