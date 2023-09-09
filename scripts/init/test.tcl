#!/bin/sh
# statusbar.tcl \
exec tclsh "$0" "$@"

set path [ exec echo "${PATH}"  ]
puts ${path}
