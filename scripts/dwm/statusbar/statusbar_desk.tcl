#!/bin/sh
# statusbar.tcl \
exec tclsh "$0" "$@"

set path "/home/klolrannet/linux-conf/scripts/dwm/statusbar"
set counter 0

while { true } {
	set cap [ exec ${path}/capacity.tcl ] 
	set cap_state [ exec ${path}/capacity_state.tcl ]
	set date [ exec ${path}/date.tcl ]
	set temp [ exec ${path}/temp.tcl ]
	
	if { ${cap_state} == "Discharging" } {
		set ch_symb "-"
	} else {
		set ch_symb "+"
	}

	exec xsetroot -name "${temp}°C | ${ch_symb}${cap}% | ${date}"

	if { ${cap} <= 20 && ${cap_state} == "Discharging" } {
		set counter [ expr ${counter} + 1 ]
		if { $counter > 30 } {
			set i 0
			set str [ exec ls -l /dev/pts | tail -n +2 | tr -s " " | cut -d " " -f "3,10" ]
			puts [ llength $str ]
			set itr [ expr [ llength $str ] / 2 ]
			for {} { $itr > 0 } { set itr [ expr $itr - 1 ] } {
				set user [ lindex $str [ 1expr $i * 2 ] ]
				if { $env(USER) == $user } {
					set term_num [ lindex $str [ expr $i * 2 + 1 ] ]
					exec echo "Attemption! Low capacity!" | tee /dev/pts/${term_num}
				}	
				set i [ expr $i + 1 ]
			}
			set counter 0
		}
	} else {
		set counter 0
	}
}





