#!/bin/sh
# statusbar.tcl \
exec tclsh "$0" "$@"

set path "/home/klolrannet/linux-conf/scripts/dwm/statusbar"

while { true } {
	set date [ exec ${path}/date.tcl ]
	set temp [ exec ${path}/temp.tcl ]
	
	exec xsetroot -name "${temp}°C | ${date}"
}





