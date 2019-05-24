#! /bin/bash

xinput --set-prop "Microsoft Surface Keyboard Touchpad" "libinput Accel Speed" 0.5
dunst &
compton &
nitrogen --restore &
xautolock -time 10 -locker 'i3lock-fancy' -notify 30 -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'" &

syncshared >/dev/null &
newsup >/dev/null &
mailsync >/dev/null &

fnews()
{
        local result=$(news)
        [ "${result}" != "" ] && echo "📰 ${result} | "
}

fpacpackages()
{
        local result=$(pacpackages)
        [ "${result}" != "" ] && echo "📦 ${result} | "
}

fmailbox()
{
        local result=$(mailbox)
        [ "${result}" != "" ] && echo "📬 ${result} | "
}

fweather()
{
        local result=$(weather)
        [ "${result}" != "" ] && echo "${result} | "
}

fbattery()
{
        local capacity=$(cat /sys/class/power_supply/"$1"/capacity) || exit
        local status=$(cat /sys/class/power_supply/"$1"/status)

        [ "${capacity}" -lt 25 ] && warn="❗" || warn=" "
        printf "%s%s%s" "$(echo "$status" | sed -e "s/,//;s/Discharging/🔋/;s/Not Charging/🛑/;s/Charging/🔌/;s/Unknown/♻️/;s/Full/⚡/;s/ 0*/ /g;s/ :/ /g")" "$warn" "$(echo "$capacity" | sed -e 's/$/%/')"
}

while true; do
        xsetroot -name "$(fnews)$(fpacpackages)$(fmailbox)$(fweather)$(volume) | $(internet) | $(disk /home 🏠) | $(fbattery BAT1) | $(fbattery BAT2) | 📅 $(clock)"
        sleep 10
done

