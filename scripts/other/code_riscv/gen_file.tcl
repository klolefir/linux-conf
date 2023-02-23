#!/bin/sh
#get_file.tcl \
exec tclsh "$0" "$@"
set instr_calc 0011OOOOOAAAAABBBBB00000000WWWWW set instr_const 0010CCCCCCCCCCCCCCCCCCCCCCCWWWWW 
set instr_ext 000100000000000000000000000WWWWW
set instr_jmp 1000000000000000000CCCCCCCC00000
set instr_condjmp 0100OOOOOAAAAABBBBBCCCCCCCC00000

set alu_op {
	ADD 00000
	SUB 01000
	SLL 00001
	SLT 00010
	SLTU 00011
	XOR 00100
	SRL 00101
	SRA 01101
	OR 00110
	AND 00111
	BEQ 11000
	BNE 11001
	BLT 11100
	BGE 11101
	BLTU 11110
	BGEU 11111
}

set alu_op_jmp {
	BEQ 11000
	BNE 11001
	BLT 11100
	BGE 11101
	BLTU 11110
	BGEU 11111
}

set const_ind_f [ string first C $instr_const ]
set const_ind_l [ string last C $instr_const ] 
set pconst_ind_f [ string first C $instr_jmp ]
set pconst_ind_l [ string last C $instr_jmp ]
set ra1_ind_f [ string first A $instr_calc ]
set ra1_ind_l [ string last A $instr_calc ]
set ra2_ind_f [ string first B $instr_calc ]
set ra2_ind_l [ string last B $instr_calc ]
set wa_ind_f [ string first W $instr_calc ]
set wa_ind_l [ string last W $instr_calc ]
set op_ind_f [ string first O $instr_calc ]
set op_ind_l [ string last O $instr_calc ]

#true value
if { 1 } {
set const_width 23
set pconst_width 8
set ra_width 5
set wa_width 5
set op_width 5
set ws_width 2
set C_width 1
set B_width 1
}

set const_width 23
set pconst_width 8
set ra_width 5
set wa_width 5
set op_width 5
set ws_width 2
set C_width 1
set B_width 1

set fd [ open CYBERcobruh.mem w ]

set N 255
set test_N $N 
set del 2
set zero 0

proc num2bin {num width} {
    binary scan [binary format "I" $num] "B*" binval
    return [string range $binval end-$width end]
} 

#######################load const#######################
for { set i 0 } { $i <= [ expr $test_N / pow(2, 3) ] } { incr i 1 } {
	#set const [ expr {round(rand() * ((pow(2, $const_width) / pow(2, $del)) - 1))} ]
	set const [ expr {round(rand() * 20)} ]
	set const [ format "%0*b" $const_width $const ]
	set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

	#set wa [ expr {round(rand() * pow(2, $wa_width))} ]
	set wa [ format "%0*b" $wa_width $i ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr
}
#######################load const#######################

######################jump######################
for { set i 0 } { $i <= [ expr $test_N / pow(2, 6) ] } { incr i 1 } {
	set jmp_val 1
	#set pconst [ expr {round(rand() * 1)} ]
	set pconst [ num2bin $jmp_val [ expr $pconst_width - 1  ] ]
	set instr [ string replace $instr_jmp $pconst_ind_f $pconst_ind_l $pconst ]
	puts $fd $instr
}
######################jump######################

#######################load const#######################
if { 0 } {
for { set i 0 } { $i <= [ expr $test_N / pow(2, 3) ] } { incr i 1 } {
	#set const [ expr {round(rand() * ((pow(2, $const_width) / pow(2, $del)) - 1))} ]
	set const [ expr {round(rand() * 20)} ]
	set const [ format "%0*b" $const_width $const ]
	set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

	#set wa [ expr {round(rand() * pow(2, $wa_width))} ]
	set wa [ format "%0*b" $wa_width $i ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr
}
}
#######################load const#######################

#######################cond jump#######################
set cond_jmp_val 1
dict for { key value } $alu_op_jmp {
	set op $value
	set instr [ string replace $instr_condjmp $op_ind_f $op_ind_l $op ]
	for { set i 0 } { $i <= [ expr { $test_N / (6 * pow(2, 3)) } ] } { incr i 1 }	{
		set ra1 [ expr {round(rand() * ((pow(2, $ra_width) / pow(2, $del)) - 1))} ]
		set ra1 [ format "%0*b" $ra_width $ra1 ]
		set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]
		set ra2 [ expr {round(rand() * ((pow(2, $ra_width) / pow(2, $del))- 1))} ]
		set ra2 [ format "%0*b" $ra_width $ra2 ]
		set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]
		#set pconst [ expr {round(rand() * 1)} ]
		set pconst [ num2bin $cond_jmp_val [ expr $pconst_width - 1  ] ]
		set instr [ string replace $instr $pconst_ind_f $pconst_ind_l $pconst ]
	}
}

#######################cond jump#######################

#######################calc instr#######################

dict for { key value } $alu_op {
	set op $value
	for { set i 0 } { $i <= [ expr { $test_N / (10 * pow(2, 1))} ] } { incr i 1 } {
		set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]
		set ra1 [ expr {round(rand() * ((pow(2, $ra_width) / pow(2, $del)) - 1))} ]
		set ra1 [ format "%0*b" $ra_width $ra1 ]
		set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]
		set ra2 [ expr {round(rand() * ((pow(2, $ra_width) / pow(2, $del))- 1))} ]
		set ra2 [ format "%0*b" $ra_width $ra2 ]
		set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]
		#set wa [ expr {round(rand() * ((pow(2, $wa_width) / pow(2, $del))- 1))} ]
		#if { $wa == [ expr { $N + 1 }  ] } {
		#		set wa $N
		#}
		#set wa [ format "%0*b" $wa_width $wa ]
		set wa [ format "%0*b" $wa_width $i ]
		set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
		puts $fd $instr
		if { 0 } {
		for { set i 0 } { $i <= [ expr { $test_N / (10 * pow(2, 3)) } ] } { incr i 1 } {
			#set const [ expr {round(rand() * ((pow(2, $const_width) / pow(2, $del)) - 1))} ]
			set const [ expr {round(rand() * 20)} ]
			set const [ format "%0*b" $const_width $const ]
			incr reg_prev 1
			incr reg_next 1
			set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

			#set wa [ expr {round(rand() * pow(2, $wa_width))} ]
			set wa [ format "%0*b" $wa_width $i ]
			set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
			puts $fd $instr
		}
		}
	}
}

#######################calc instr#######################

close $fd
