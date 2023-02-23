#!/bin/sh
#capacity.tcl \
exec tclsh "$0" "$@"
 
set cap [ exec cat /sys/class/power_supply/BAT0/capacity ]
puts $cap

