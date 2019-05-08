#! /bin/bash

xinput --set-prop "Microsoft Surface Keyboard Touchpad" "libinput Accel Speed" 0.5
dunst &
compton &
nitrogen --restore &
xautolock -time 10 -locker 'i3lock-fancy' -notify 30 -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'" &

/home/conni/bin/croncmds/getforecast kornwestheim &
/home/conni/bin/croncmds/syncshared &
/home/conni/bin/croncmds/newsup &
/usr/local/bin/mailsync &

clock()
{
     date '+%d.%m.%Y %H:%M'
}

battery()
{
        cat /sys/class/power_supply/"${1}"/capacity
}

while true; do
        #xsetroot -name "$(battery BAT1)% | $(battery BAT2)% | $(clock)"
        xsetroot -name "$(clock)"
        sleep 2
done

