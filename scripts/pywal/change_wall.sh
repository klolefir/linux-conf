#!/bin/sh

goal_color=$(ps aux --sort time | grep color | tail -n 1 | cut -d " " -f 2)
#goal_cwall=$(ps aux --sort time | grep cwall | tail -n2 | cut -d " " -f 2 | head -n1)
kill $goal_color
#kill $gola_cwall
color &
