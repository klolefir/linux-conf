#!/bin/sh
# date.tcl \
exec tclsh "$0" "$@"

set date [exec date]
puts ${date}

