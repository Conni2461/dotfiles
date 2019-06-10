#!/bin/sh

xinput --set-prop "Microsoft Surface Keyboard Touchpad" "libinput Accel Speed" 0.5
dunst &
compton &
nitrogen --restore &
xautolock -time 10 -locker 'lock' -notify 30 -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'" &

syncshared >/dev/null &
newsup >/dev/null &
mailsync >/dev/null &

dwmbar &
