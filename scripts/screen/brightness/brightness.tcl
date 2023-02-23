#!/bin/sh
# cap.tcl \
exec tclsh "$0" "$@"

set device [ exec xrandr --prop | grep "connected" | cut -d " " -f 1 ]

if { $argc >= 1 } {
	set val [ lindex $argv 0 ]
	if { $val > 0 && $val <= 100 } {
		set brightness [ expr $val / 100.0 ]
		exec xrandr --output $device --brightness $brightness 

	} else {

		puts "Set permissible value"
	}
} else {
	set brightness [ exec xrandr --prop --verbose | grep -A10 "connected" | grep "Brightness" | cut -d " " -f 2 ]
	puts "Current brightness is [ expr $brightness * 100 ]%"
}



if 0 {
	set status [ catch { puts [  exec ls -l | grep "klolefir" ] }  result ]
	puts $status
	puts $errorCode
	puts $result
}

