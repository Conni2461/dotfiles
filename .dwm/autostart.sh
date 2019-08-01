#!/bin/sh

xinput --set-prop "Microsoft Surface Keyboard Touchpad" "libinput Accel Speed" 0.5
dunst &
compton &
nitrogen --restore &
pgrep clipmenud >/dev/null|| clipmenud &

syncshared >/dev/null &
newsup >/dev/null &
mailsync >/dev/null &

dwmbar &

calnotify 30
