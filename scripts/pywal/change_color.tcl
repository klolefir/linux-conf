#!/bin/sh
# set_color.tcl \
exec tclsh "$0" "$@"


set user [ exec whoami ]
set colors_file "/home/${user}/.cache/wal/colors"
set xres_file "/home/${user}/.Xresources"
array set color_array {}

if { [ catch { set fd [ open "${colors_file}" ] } open_err ] } {
	puts stderr "${open_err}"
	exit 2
}


set i 0
while { [ gets ${fd} color ] >= 0 } {
	set color_array(${i}) ${color}
	incr i
}

set list1 "dwm.normfgcolor: dwm.titlenormfgcolor: dwm.tagsnormfgcolor: dwm.urgfgcolor: "

set list2 "dwm.normbgcolor: dwm.titlenormbgcolor: dwm.tagsnormbgcolor: dwm.hidnormbgcolor: dwm.hidselbgcolor: dwm.urgbgcolor: "

set list3 "dwm.normbordercolor: dwm.titlenormbordercolor: dwm.tagsnormbordercolor: "

set list4 "dwm.normfloatcolor: dwm.titlenormfloatcolor: dwm.tagsnormfloatcolor: dwm.urgfloatcolor: "

set list5 "dwm.selfgcolor: "

set list6 "dwm.selbgcolor: dwm.selbordercolor: dwm.selfloatcolor: dwm.titleselbgcolor: dwm.titleselbordercolor: dwm.titleselfloatcolor: dwm.tagsselbgcolor: dwm.tagsselbordercolor: dwm.tagsselfloatcolor: dwm.hidnormfgcolor: "

set list7 "dwm.hidselfgcolor: "

set list8 "dwm.urgbordercolor: "

set list9 "dwm.titleselfgcolor: dwm.tagsselfgcolor: "

set end_list ""

set i 0
foreach str $list1 {
	append end_list ${str} 
	append end_list $color_array(${i}) "\n"
}
incr i
foreach str $list2 {
	append end_list ${str}  $color_array(${i}) "\n"
}
incr i
foreach str $list3 {
	append end_list ${str}  $color_array(${i}) "\n"
}
incr i
foreach str $list4 {
	append end_list ${str}  $color_array(${i}) "\n"
}
incr i
foreach str $list5 {
	append end_list ${str}  $color_array(${i}) "\n"
}
incr i
foreach str $list6 {
	append end_list ${str}  $color_array(${i}) "\n"
}
incr i
foreach str $list7 {
	append end_list ${str}  $color_array(${i}) "\n"
}
incr i
foreach str $list8 {
	append end_list ${str}  $color_array(${i}) "\n"
}
incr i
foreach str $list9 {
	append end_list ${str}  $color_array(${i}) "\n"
}

if { [ catch { set xd [ open "${xres_file}" "w" ] } open_err ] } {
	puts stderr "${open_err}"
	exit 2
}

foreach str ${end_list} {
	puts ${xd} ${str}
}
