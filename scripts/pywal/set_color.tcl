#!/bin/sh
# set_color.tcl \
exec tclsh "$0" "$@"

while { true } {

	set file [ exec find /home/klolrannet/pictures/ -type f | shuf -n1 ]

	exec /home/klolrannet/.local/bin/wal -i $file
	exec /usr/bin/python3 /home/klolrannet/linux-conf/scripts/pywal/change_color.py
	exec xrdb -merge /home/klolrannet/.Xresources
	exec xdotool key shift+alt+F5
	#exec /home/klolrannet/.local/bin/pywalfox update

	exec sleep 15m
}


