#!/bin/sh
# set_color.tcl \
exec tclsh "$0" "$@"

set user [ exec whoami ]

while { true } {

	#set file [ exec find /home/${user}/images/pictures_xxx -type f | shuf -n1 ]
	set file [ exec find /home/${user}/images/wallhaven -type f | shuf -n1 ]

	exec /home/${user}/.local/bin/wal -i $file
	exec /home/${user}/linux-conf/scripts/pywal/change_color.tcl
	exec xrdb -merge /home/${user}/.Xresources
	exec xdotool key shift+alt+F5
	#exec /home/${user}/.local/bin/pywalfox update

	exec sleep 15m
}


