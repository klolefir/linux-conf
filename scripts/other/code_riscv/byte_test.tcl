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
set sw_func3 2
set sh_func3 1
set sb_func3 0
set lb_func3 0
set lh_func3 1
set lw_func3 2
set lbu_func3 4
set lhu_func3 5 

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

set instr_num 101 

#addi gp, zero, instr_num 
set gp 3
set op [ dict get $opcode "I" ]
puts $op
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $gp 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm [ expr $instr_num * 4 ] 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

set test_N 10 

#lw x(5-14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "I_load" ]
	set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

	set func3 $lw_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rd [ expr $i + 5 ]
	set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
	set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

	set imm [ expr $i * 4 ] 
	set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
	set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
	incr instr_num
	puts $fd $instr
}

set data_count 1
#sw x(5-14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "S" ]
	set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

	set func3 $sw_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rs2 [ expr $i + 5 ]  
	set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
	set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

	set imm	[ expr (($i + ($test_N * $data_count))) * 4 ] 
	set imm [ num2bin $imm [ expr 12 - 1 ] ]

	set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
	set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
	incr instr_num
	puts $fd $instr
}

incr data_count

if { 1 } {
#lh x(x5-x14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "I_load" ]
	set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

	set func3 $lh_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rd [ expr $i + 5 ]
	set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
	set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

	set imm	[ expr ($i + ($test_N * ($data_count - 1))) * 4 ] 
	set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
	set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
	incr instr_num
	puts $fd $instr
}
#
#sw x(5-14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "S" ]
	set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

	set func3 $sw_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rs2 [ expr $i + 5 ]  
	set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
	set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

	set imm	[ expr ($i + ($test_N * $data_count)) * 4 ] 
	set imm [ num2bin $imm [ expr 12 - 1 ] ]

	set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
	set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
	incr instr_num
	puts $fd $instr
}

incr data_count

#lhu x(x5-x14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "I_load" ]
	set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

	set func3 $lhu_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rd [ expr $i + 5 ]
	set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
	set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

	set imm	[ expr ($i + ($test_N * ($data_count - 1))) * 4 ] 
	set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
	set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
	incr instr_num
	puts $fd $instr
}

#sw x(5-14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "S" ]
	set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

	set func3 $sw_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rs2 [ expr $i + 5 ]  
	set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
	set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

	set imm	[ expr ($i + ($test_N * $data_count)) * 4 ] 
	set imm [ num2bin $imm [ expr 12 - 1 ] ]

	set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
	set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
	incr instr_num
	puts $fd $instr
}

incr data_count


#lb x(x5-x14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "I_load" ]
	set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

	set func3 $lb_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rd [ expr $i + 5 ]
	set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
	set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

	set imm	[ expr ($i + ($test_N * ($data_count - 1))) * 4 ] 
	set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
	set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
	incr instr_num
	puts $fd $instr
}

#sw x(5-14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "S" ]
	set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

	set func3 $sw_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rs2 [ expr $i + 5 ]  
	set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
	set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

	set imm	[ expr ($i + ($test_N * $data_count)) * 4 ] 
	set imm [ num2bin $imm [ expr 12 - 1 ] ]

	set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
	set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
	incr instr_num
	puts $fd $instr
}
incr data_count

#lbu x(x5-x14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "I_load" ]
	set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

	set func3 $lbu_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rd [ expr $i + 5 ]
	set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
	set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

	set imm	[ expr ($i + ($test_N * ($data_count - 1))) * 4 ] 
	set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
	set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
	incr instr_num
	puts $fd $instr
}

#sw x(5-14) imm(gp)
for { set i 0 } { $i < $test_N } { incr i } {
	set op [ dict get $opcode "S" ]
	set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

	set func3 $sw_func3
	set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
	set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

	set rs1 $gp
	set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
	set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

	set rs2 [ expr $i + 5 ]  
	set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
	set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

	set imm	[ expr ($i + ($test_N * $data_count)) * 4 ] 
	set imm [ num2bin $imm [ expr 12 - 1 ] ]

	set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
	set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
	incr instr_num
	puts $fd $instr
}
incr data_count


}

puts $instr_num
set const_width 32
for { set i 0 } { $i < $test_N } { incr i } { 
	set const [ expr {round(rand() * pow(2, 25)) } ]
	#set const $i
	set const [ num2bin $const $const_width ] 
	puts $fd $const
}

close $fd
