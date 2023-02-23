#!/usr/bin/tclsh
#

set str [ exec ls -l /dev/pts | tail -n +2 | tr -s " " | cut -d " " -f "3,10" ]
puts $str
puts "\n"
set owner $env(USER) 
puts [ lindex $str 1 ]
puts "\n"


foreach num $str {
	puts ${num}
}       

