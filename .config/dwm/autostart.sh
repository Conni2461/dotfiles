#!/bin/sh

pgrep dunst >/dev/null || dunst &
pgrep clipmenud >/dev/null|| clipmenud &

ministatus 2>/tmp/ministatus.log &

xset r rate 300 50
