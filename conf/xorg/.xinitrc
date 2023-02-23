day
/home/klolefir/scripts/pulseaudio/pulse.sh
feh --bg-scale /home/klolefir/pictures/rose.png &
/home/klolefir/scripts/statusbar/statusbar.tcl &
/home/klolefir/soft/picom/build/src/picom -b -i 0.8 -e 0.8 --active-opacity 0.8 --no-fading-openclose --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 500 &

export PATH=${PATH}:/usr/sbin

exec dwm



