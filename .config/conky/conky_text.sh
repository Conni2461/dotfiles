#!/bin/sh

echo "\${color1}\${font Noto Sans Mono:size=16}Date and Time"
echo "\${font}\${color}\${time %B %d %Y}"
echo "\${font}\${time %A}"
echo "\${font Noto Sans Mono:size=30}\${color}\${time %I:%M%p}"
echo "\${color1}\${font}NEW YORK      \${color}\${tztime America/New_York %m/%d/%Y %I:%M%p}"
echo "\${color1}\${font}LOS ANGELES   \${color}\${tztime America/Los_Angeles %m/%d/%Y %I:%M%p}"
echo "\${color1}\${font}TOKYO         \${color}\${tztime Asia/Tokyo %m/%d/%Y %I:%M%p}"

if [ "$(calcurse -a)" != "" ]; then
	echo
	echo "\${color1}\${font}APPOINTMENTS"
	echo "\${color}\${exec lsappointments}"
fi

news=$(listnews | sed 's/\#/\\#/g')
if [ "${news}" != "" ]; then
	echo
	echo "\${color1}\${font}NEWS"
	echo "\${color}${news}"
fi

if [ ! -f /tmp/today_netflix ] || [ "$(date +%M:%S)" = "00:00" ]; then
	netflixdb -t >/tmp/today_netflix
fi

if [ "$(cat /tmp/today_netflix)" != "" ]; then
	echo
	echo "\${color1}\${font}NETFLIX"
	echo "\${color}\${exec cat /tmp/today_netflix}"
fi

if [ ! -f /tmp/today_amazon ] || [ "$(date +%M:%S)" = "00:00" ]; then
	amazondb -t >/tmp/today_amazon
fi

if [ "$(cat /tmp/today_amazon)" != "" ]; then
	echo
	echo "\${color1}\${font}AMAZON"
	echo "\${color}\${exec cat /tmp/today_amazon}"
fi

if [ "$(liststreams)" != "" ]; then
	echo
	echo "\${color1}\${font}TWITCH"
	echo "\${color}\${exec liststreams}"
fi

echo
echo "\${color1}\${font}UPTIME"
echo "\${color}\$uptime"
