#!/bin/sh
#night.tcl \
exec tclsh "$0" "$@"

set device [ exec xrandr --prop | grep "connected" | cut -d " " -f 1 ]
set brightness 0.7
set gamma "1:0.7:0.4"

exec xrandr --output $device --brightness $brightness --gamma $gamma
