#!/bin/sh
#get_file.tcl \
exec tclsh "$0" "$@"


set instr_const 0010CCCCCCCCCCCCCCCCCCCCCCCWWWWW 
set instr_calc 0011OOOOOAAAAABBBBB00000000WWWWW
set instr_ext 000100000000000000000000000WWWWW

set const_ind_f [ string first C $instr_const ]
set const_ind_l [ string last C $instr_const ] 
set ra1_ind_f [ string first A $instr_calc ]
set ra1_ind_l [ string last A $instr_calc ]
set ra2_ind_f [ string first B $instr_calc ]
set ra2_ind_l [ string last B $instr_calc ]
set wa_ind_f [ string first W $instr_calc ]
set wa_ind_l [ string last W $instr_calc ]
set op_ind_f [ string first O $instr_calc ]
set op_ind_l [ string last O $instr_calc ]

set const_width 23
set pconst_width 8
set ra_width 5
set wa_width 5
set op_width 5

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

set fd [ open CYBERtask.mem w ]

set N 32

proc num2bin {num width} {
    binary scan [binary format "I" $num] "B*" binval
    return [string range $binval end-$width end]
}

set IN_adr 2


#########################################################################
if { 0 } {
#load const 1
set one_adr 1
set const 1
set const [ format "%0*b" $const_width $const ]
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $one_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr

#load const 2
set two_adr 2
set const 2
set const [ format "%0*b" $const_width $const ]
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $two_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr

#load IN
set IN_adr 3
set const [ expr {round(rand() * 20)} ]
if { $argc <= 0 } {
	error "Enter const!"
}
set const [ lindex $argv 0 ]
set const [ format "%0*b" $const_width $const ]
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $IN_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr

#keep IN
set keep_IN_adr 31
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $keep_IN_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr


#load shift
set shift_adr 4
set const 0 
set const [ format "%0*b" $const_width $const ]
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $shift_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr


for { set i 5 } { $i < [ expr {$N / 2 + 5} ] } { incr i 1 } {
	#one AND IN_const
	set op [ dict get $alu_op "AND" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $one_adr
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $IN_adr
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $i ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr

	#IN_const >> 2
	set op [ dict get $alu_op "SRL" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $IN_adr
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $two_adr
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $IN_adr ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr

	#reg_val << shift
	set op [ dict get $alu_op "SLL" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $i
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $shift_adr
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $i ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr


	#shift incr
	set op [ dict get $alu_op "ADD" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $one_adr
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $shift_adr
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $shift_adr ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr
}

set reg_prev [ expr $shift_adr + 1 ]
set reg_next [ expr $reg_prev + 1 ]
for { set i 0 } { $i < [ expr $N / 2 ] } { incr i 1 } {
	set op [ dict get $alu_op "OR" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $reg_prev
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $reg_next
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $reg_next ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr

	incr reg_prev 1
	incr reg_next 1
}

}
#########################################################################

##EXTERNAL DATA
#load const 1
set one_adr 1
set const 1
set const [ format "%0*b" $const_width $const ]
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $one_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr

#load const 2
set two_adr 2
set const 2
set const [ format "%0*b" $const_width $const ]
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $two_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr

#load IN
set IN_adr 3

set wa [ format "%0*b" $wa_width $IN_adr ]
set instr [ string replace $instr_ext $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr

#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#
if { 0 } {
#keep IN
set keep_IN_adr 31
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $keep_IN_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr
}
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#


#load shift
set shift_adr 4
set const 0 
set const [ format "%0*b" $const_width $const ]
set instr [ string replace $instr_const $const_ind_f $const_ind_l $const ]

set wa [ format "%0*b" $wa_width $shift_adr ]
set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
puts $fd $instr


for { set i 5 } { $i < [ expr {$N / 2 + 5} ] } { incr i 1 } {
	#one AND IN_const
	set op [ dict get $alu_op "AND" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $one_adr
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $IN_adr
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $i ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr

	#IN_const >> 2
	set op [ dict get $alu_op "SRL" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $IN_adr
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $two_adr
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $IN_adr ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr

	#reg_val << shift
	set op [ dict get $alu_op "SLL" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $i
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $shift_adr
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $i ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr


	#shift incr
	set op [ dict get $alu_op "ADD" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $one_adr
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $shift_adr
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $shift_adr ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr
}

set reg_prev [ expr $shift_adr + 1 ]
set reg_next [ expr $reg_prev + 1 ]
for { set i 0 } { $i < [ expr $N / 2 ] } { incr i 1 } {
	set op [ dict get $alu_op "OR" ]
	set instr [ string replace $instr_calc $op_ind_f $op_ind_l $op ]

	set ra1 $reg_prev
	set ra1 [ format "%0*b" $ra_width $ra1 ]
	set instr [ string replace $instr $ra1_ind_f $ra1_ind_l $ra1 ]

	set ra2 $reg_next
	set ra2 [ format "%0*b" $ra_width $ra2 ]
	set instr [ string replace $instr $ra2_ind_f $ra2_ind_l $ra2 ]

	set wa [ format "%0*b" $wa_width $reg_next ]
	set instr [ string replace $instr $wa_ind_f $wa_ind_l $wa ]
	puts $fd $instr

	incr reg_prev 1
	incr reg_next 1
}


