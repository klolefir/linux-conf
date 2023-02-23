#!/bin/sh
#gamma.tcl \
exec tclsh "$0" "$@"

proc setgamma { gamma } {
	set device [ exec xrandr --prop | grep "connected" | cut -d " " -f 1 ]
	set brightness [ exec xrandr --prop --verbose | grep -A10 "connected" | grep "Brightness" | cut -d " " -f 2 ]
	exec xrandr --output $device --brightness $brightness --gamma $gamma

}

if { $argc == 1 } {
	set gamma [ lindex $argv 0 ]
	set warm "1.0:0.7:0.4"
	set normal "1.0:1.0:1.0"
	set cold "0.7:0.8:1.0"
	switch $gamma {
		normal {
			setgamma $normal 
		}
		warm {
			setgamma $warm
		}
		cold {
			setgamma $cold 
		}
	}
}
if { $argc == 3 } {
	foreach val $argv {
		append gamma "$val:"
	}	
	set gamma [ exec echo $gamma | sed {s/.$//} ]
	setgamma $gamma
}

