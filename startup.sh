#!/bin/sh

i3-msg 'workspace 1:🌍; exec chromium'
sleep 3
i3-msg 'workspace 2:🖥; exec gnome-terminal -- tmux'
i3-msg 'workspace 4:🎵; exec spotify'
compton &
