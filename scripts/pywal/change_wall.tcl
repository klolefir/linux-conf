#!/bin/sh
# set_color.tcl \
exec tclsh "$0" "$@"

set user [ exec whoami ]

set color_path "/home/${user}/linux-conf/scripts/pywal"

if { [ catch { set color [ exec ps aux | grep -v grep | grep set_color | tr -s " " | cut -d " " -f 2 ] } color_err ] } {
	puts stderr "$color_err"
} else {
	exec kill ${color}
}

exec ${color_path}/set_color.tcl &
