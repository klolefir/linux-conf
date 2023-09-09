#!/bin/sh
# set_color.tcl \
exec tclsh "$0" "$@"

set user [ exec whoami ]

set color_path "/home/${user}/linux-conf/scripts/pywal"

if { [ catch { set color [ exec ps aux | grep -v grep | grep set_color | cut -d " " -f 3 ] } color_err ] } {
	puts stderr "$color_err"
	exit 2
}

puts ${color}
exec kill ${color}
exec ${color_path}/set_color.tcl &
