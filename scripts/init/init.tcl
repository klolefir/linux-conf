#!/bin/sh
# statusbar.tcl \
exec tclsh "$0" "$@"

set user [ exec whoami ]
set pulse_path "/home/${user}/linux-conf/scripts/other/pulseaudio"
set statusbar_path "/home/${user}/linux-conf/scripts/dwm/statusbar"
set picom_path "/home/${user}/linux-conf/scripts/picom"
set color_path "/home/${user}/linux-conf/scripts/pywal"

#exec export [ PATH=${PATH}:/usr/sbin:/sbin:/home/klolefir/.local/bin ]
exec ${pulse_path}/pulse.sh
exec ${statusbar_path}/statusbar_desk.tcl &
exec ${picom_path}/picom.tcl
exec ${color_path}/set_color.tcl &

exec xrandr --setprovideroutputsource modesetting NVIDIA-0
exec xrandr --auto

exec dwm
