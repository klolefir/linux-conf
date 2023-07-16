#!/bin/sh
# set_color.tcl \
exec tclsh "$0" "$@"

while { true } {
	set period [ exec date | cut -d " " -f 6 ]
	set current_hour [ exec date | cut -d " " -f 5 | cut -d ":" -f 1 ]

	set file [ exec find /home/klolefir/pictures/ -type f | shuf -n1 ]

	exec /home/klolefir/.local/bin/wal -i $file
	exec /usr/bin/python3 /home/klolefir/scripts/pywal/change_color.py
	exec xrdb -merge /home/klolefir/.Xresources
	exec xdotool key shift+alt+F5
	exec /home/klolefir/.local/bin/pywalfox update

	exec sleep 15m
}


