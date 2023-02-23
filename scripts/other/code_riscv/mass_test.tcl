#!/bin/sh
#riscv_test.tcl \
exec tclsh "$0" "$@"
set instr_I IIIIIIIIIIIIAAAAA333DDDDDOOOOO11
set instr_R 7777777BBBBBAAAAA333DDDDDOOOOO11
set instr_B FFFFFFFBBBBBAAAAA333LLLLLOOOOO11
set instr_J IIIIIIIIIIIIIIIIIIIIDDDDDOOOOO11
set instr_S FFFFFFFBBBBBAAAAA333LLLLLOOOOO11
set addi_func3 0
set add_func3 0
set add_func7 0
set sub_func3 0
set sub_func7 32
set beq_func3 0
set bge_func3 5
set bne_func3 1
set lw_func3 2
set sw_func3 2

set func3_width 3
set func7_width 7
set rs1_width 5
set rs2_width 5
set rd_width 5
set opcode_width 5
set immI_width 12

proc num2bin {num width} {
	binary scan [binary format "I" $num] "B*" binval
	return [string range $binval end-$width end]
}

set fd [ open riscv_test.mem w ]

set opcode {
	R 01100
	I 00100
	I_load 00000
	S 01000
	B 11000
	J 11011
	U 01101
}

set op_ind_f [ string first O $instr_R ]
set op_ind_l [ string last O $instr_R ]
set func3_ind_f [ string first 3 $instr_R ]
set func3_ind_l [ string last 3 $instr_R ]
set func7_ind_f [ string first 7 $instr_R ]
set func7_ind_l [ string last 7 $instr_R ]
set immI_ind_f [ string first I $instr_I ]
set immI_ind_l [ string last I $instr_I ]
set rs1_ind_f [ string first A $instr_R ]
set rs1_ind_l [ string last A $instr_R ]
set rs2_ind_f [ string first B $instr_R ]
set rs2_ind_l [ string last B $instr_R ]
set rd_ind_f [ string first D $instr_R ]
set rd_ind_l [ string last D $instr_R ]
set immB_ind_ff [ string first F $instr_B ]
set immB_ind_fl [ string last F $instr_B ]
set immB_ind_lf [ string first L $instr_B ]
set immB_ind_ll [ string last L $instr_B ]
set immJ_ind_f [ string first I $instr_J ]
set immJ_ind_l [ string last I $instr_J ]
set immS_ind_ff [ string first F $instr_S ]
set immS_ind_fl [ string last F $instr_S ]
set immS_ind_lf [ string first L $instr_S ]
set immS_ind_ll [ string last L $instr_S ]

set zero 0
set N 31

set i 1

#add x1, x0, x0 
set op [ dict get $opcode "R" ]
set instr [ string replace $instr_R $op_ind_f $op_ind_l $op ]

set func3 $add_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set func7 $add_func7
set func7 [ num2bin $func7 [ expr $func7_width - 1  ] ]
set instr [ string replace $instr $func7_ind_f $func7_ind_l $func7 ]

set rs1 0 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 0 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set rd 1 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

puts $fd $instr


set instr_number 63
#lw x1 imm(x0)
for { set i 1 } { $i <= $N } { incr i } {
	set op [ dict get $opcode "I_load" ]
	set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

	set func3 $lw_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $zero
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rd $i
	set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
	set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

	set imm [ expr ($instr_number + ($i - 1)) * 4 ] 
	set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
	set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]

	puts $fd $instr
}

set rs_prev 1
set rs_next 2

#add x1, x2, x2 
for { set i 1 } { $i < $N } { incr i 1 } {
	set op [ dict get $opcode "R" ]
	set instr [ string replace $instr_R $op_ind_f $op_ind_l $op ]

	set func3 $add_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set func7 $add_func7
	set func7 [ num2bin $func7 [ expr $func7_width - 1  ] ]
	set instr [ string replace $instr $func7_ind_f $func7_ind_l $func7 ]

	set rs1 $rs_prev 
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rs2 $rs_next 
	set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
	set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

	set rd $rs_next 
	set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
	set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

	puts $fd $instr

	incr rs_prev
	incr rs_next
}

#sw x31 imm(x0)
set op [ dict get $opcode "S" ]
set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

set func3 $sw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 30 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

#set imm [ expr (1 + 1 + 1 + 32 + 32 + 1 + 1) * 4 ] 
#100000100
#set imm 010000010000
set imm [ expr $instr_number * 4 + 4 ] 
set imm [ num2bin $imm [ expr 12 - 1 ] ]

puts $imm
#set instr [ string replace $instr $immS_ind_ff $immS_ind_fl 0000000 ]
#set instr [ string replace $instr $immS_ind_lf $immS_ind_ll 01000 ]

set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
puts [ string range $imm 0 6 ]
set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
puts [ string range $imm 7 11 ]
puts $fd $instr

if { 0 } {
#add x1, x0, x0 
set op [ dict get $opcode "R" ]
set instr [ string replace $instr_R $op_ind_f $op_ind_l $op ]

set func3 $add_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set func7 $add_func7
set func7 [ num2bin $func7 [ expr $func7_width - 1  ] ]
set instr [ string replace $instr $func7_ind_f $func7_ind_l $func7 ]

set rs1 0 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 0 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set rd 1 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

puts $fd $instr


#lw x1 imm(x0)
set op [ dict get $opcode "I_load" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $lw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd 1 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

#set imm [ expr (1 + 1 + 1 + 32 + 32 + 1 + 1) * 4 ] 
set imm [ expr 65 * 4 ] 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set imm 010000010000
puts $imm
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]

puts $fd $instr
}


set const_width 32
for { set i 1024 } { $i <= [ expr $N + 1024 ] } { incr i } { 
	set const $i
	set const [ num2bin $const $const_width ] 
	puts $fd $const
}

close $fd
