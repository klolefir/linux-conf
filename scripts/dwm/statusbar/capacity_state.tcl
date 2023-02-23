#!/bin/sh
#capacity_state.tcl \
exec tclsh "$0" "$@"

set cap_state [ exec cat /sys/class/power_supply/BAT0/status ]
puts $cap_state
