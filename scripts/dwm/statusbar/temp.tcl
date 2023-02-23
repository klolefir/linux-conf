#!/bin/sh
#temp.tcl \
exec tclsh "$0" "$@"

set path "/sys/class/thermal/thermal_zone0/temp"
set temp [ expr [ exec cat $path ] / 1000.0 ]
puts $temp
