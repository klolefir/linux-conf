#!/bin/sh
#night.tcl \
exec tclsh "$0" "$@"

set device [ exec xrandr --prop | grep "connected" | cut -d " " -f 1 ]
set brightness 1 
set gamma "1:1:0.9"

exec xrandr --output $device --brightness $brightness --gamma $gamma
