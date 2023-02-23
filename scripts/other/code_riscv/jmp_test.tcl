#!/bin/sh
#jmp_test.tcl \
exec tclsh "$0" "$@"

#proc num2bin {num width} {
    binary scan [binary format "I" $num] "B*" binval
    return [string range $binval end-$width end]
} 
puts [ num2bin -2 2 ]
