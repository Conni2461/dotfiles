#!/bin/sh

i3-msg 'workspace 1:🌍; exec chromium'
sleep 3
i3-msg 'workspace 2:🖥; exec gnome-terminal -- tmux'
sleep 1
i3-msg 'workspace 3:📝; exec clion'
compton &
