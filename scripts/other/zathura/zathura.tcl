#!/bin/sh
#zathura.tcl \
exec tclsh "$0" "$@"

set path "/home/klolefir/.local/share/zathura/history" 
set book [ exec cat $path | tail -n 24 | head -n 1 | sed {s/.//;s/.$//} ]

exec zathura --fork $book
