#!/bin/sh
# statusbar.tcl \
exec tclsh "$0" "$@"

set user [ exec whoami ]
set path "/home/${user}/soft/picom/build/src"
exec ${path}/picom -b -i 0.8 -e 0.8 --active-opacity 0.8 --no-fading-openclose --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 500 --experimental-backends --transparent-clipping
