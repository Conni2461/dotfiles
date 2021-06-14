#!/bin/sh

userresources=$HOME/.Xresources

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

numlockx &

case $1 in
  i3)
    exec i3
    ;;
  dwm)
    exec startdwm
    ;;
  awesome)
    exec awesome >/tmp/awesomelog.1 2>/tmp/awesomelog.2
    ;;
  budgie)
    export XDG_CURRENT_DESKTOP=Budgie:GNOME
    exec budgie-desktop
    ;;
  deepin)
    exec startdde
    ;;
  *)
    exec startdwm
    ;;
esac
