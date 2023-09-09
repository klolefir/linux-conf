#!/bin/sh
#zathura.tcl \
exec tclsh "$0" "$@"

set user [ exec whoami ]
set path "/home/${user}/.local/share/zathura/history" 
set book [ exec cat $path | tail -n 24 | head -n 1 | sed {s/.//;s/.$//} ]

exec zathura --fork $book
