#!/bin/sh

while true
do
	period=$(date | cut -d " " -f 6)
	current_hour=$(date | cut -d " " -f 5 | cut -d ":" -f 1)

	if ( $period == "PM" ); then
		echo $period
	fi

	if [ $period -eq 'PM' ] && [ $current_hour -lt '06' ] || [ $period -eq 'AM' ] && [ $current_hour -gt '03' ]; then
		echo "im in day"
		file=$(find /home/klolefir/pictures/ -type f | grep "m_" | shuf -n1)
	else
		echo "im in night"
		file=$(find /home/klolefir/pictures/ -type f | shuf -n1)
	fi
	/home/klolefir/.local/bin/wal -i $file
	/usr/bin/python3 /home/klolefir/scripts/pywal/change_color.py
	xrdb -merge /home/klolefir/.Xresources
	xdotool key shift+alt+F5
	/home/klolefir/.local/bin/pywalfox update
	sleep 15m
done
