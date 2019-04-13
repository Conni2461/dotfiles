#! /bin/bash

xinput --set-prop "Microsoft Surface Keyboard Touchpad" "libinput Accel Speed" 0.5
dunst &
compton &
nitrogen --restore &
xfce4-power-manager
