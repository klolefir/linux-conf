#!/bin/sh
#get_file.tcl \
exec tclsh "$0" "$@"

set instr_I IIIIIIIIIIIIAAAAA333DDDDDOOOOO11
set instr_R 7777777BBBBBAAAAA333DDDDDOOOOO11
set instr_B FFFFFFFBBBBBAAAAA333LLLLLOOOOO11
set instr_J IIIIIIIIIIIIIIIIIIIIDDDDDOOOOO11

set addi_func3 0
set add_func3 0
set add_func7 0
set sub_func3 0
set sub_func7 32
set beq_func3 0
set bge_func3 5
set bne_func3 1
set lw_func3 2

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

#########################TEST#########################
if { 0 } {
proc ReplaceImmB { num } {
	set imm0 [ string index 11 ]
	set imm
}
}
#########################TEST#########################

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

set zero 0

if { 0 } {
#load value in reg1
set op [ dict get $opcode "I_load" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $lw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd 1
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]
}

#addi x1, zero, 13
set op [ dict get $opcode "I" ]
puts $op
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd 1 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 13
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]

puts $fd $instr

#add x2, x1, zero
set op [ dict get $opcode "R" ]
set instr [ string replace $instr_R $op_ind_f $op_ind_l $op ]

set func3 $add_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set func7 $add_func7
set func7 [ num2bin $func7 [ expr $func7_width - 1  ] ]
set instr [ string replace $instr $func7_ind_f $func7_ind_l $func7 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 1 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set rd 2 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

puts $fd $instr

#addi x3, zero, 2 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd 3 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 2 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]

puts $fd $instr

#bge zero, x3, 12 
set op [ dict get $opcode "B" ]
set instr [ string replace $instr_B $op_ind_f $op_ind_l $op ]

set func3 $bge_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 2 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set instr [ string replace $instr $immB_ind_ff $immB_ind_fl 0000000 ]
set instr [ string replace $instr $immB_ind_lf $immB_ind_ll 11000 ]

#0000_0000_1100
#0_000000_11000

puts $fd $instr

#sub x2, x2, x3
set op [ dict get $opcode "R" ]
set instr [ string replace $instr_R $op_ind_f $op_ind_l $op ]

set func3 $sub_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set func7 $sub_func7
set func7 [ num2bin $func7 [ expr $func7_width - 1  ] ]
set instr [ string replace $instr $func7_ind_f $func7_ind_l $func7 ]

set rs1 2 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 3 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set rd 2 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

puts $fd $instr

#jal zero -8(j -6) 
set op [ dict get $opcode "J" ]
set instr [ string replace $instr_J $op_ind_f $op_ind_l $op ]

set rd $zero 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set instr [ string replace $instr $immJ_ind_f $immJ_ind_l 11111111000111111111 ]

puts $fd $instr

#beq x2, zero, 16 

set op [ dict get $opcode "B" ]
set instr [ string replace $instr_B $op_ind_f $op_ind_l $op ]

set func3 $beq_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 2 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set instr [ string replace $instr $immB_ind_ff $immB_ind_fl 0000001 ]
set instr [ string replace $instr $immB_ind_lf $immB_ind_ll 00000 ]

#0000_0001_0000
#0_000001_00000

puts $fd $instr

#addi x3, x3, 1 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 3 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd 3 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 1 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]

puts $fd $instr

#add x2, x1, zero
set op [ dict get $opcode "R" ]
set instr [ string replace $instr_R $op_ind_f $op_ind_l $op ]

set func3 $add_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set func7 $add_func7
set func7 [ num2bin $func7 [ expr $func7_width - 1  ] ]
set instr [ string replace $instr $func7_ind_f $func7_ind_l $func7 ]

set rs1 $zero 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 1 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set rd 2 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

puts $fd $instr

#jal zero -24(j -24) 
set op [ dict get $opcode "J" ]
set instr [ string replace $instr_J $op_ind_f $op_ind_l $op ]

set rd $zero 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set instr [ string replace $instr $immJ_ind_f $immJ_ind_l 11111101000111111111 ]

#0000_0000_0000_0001_1000
#1111_1111_1111_1110_1000
#1_1111101000_111111111


puts $fd $instr

#bne x1, x3, 12 
set op [ dict get $opcode "B" ]
set instr [ string replace $instr_B $op_ind_f $op_ind_l $op ]

set func3 $bne_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 1 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 3 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set instr [ string replace $instr $immB_ind_ff $immB_ind_fl 0000000 ]
set instr [ string replace $instr $immB_ind_lf $immB_ind_ll 11000 ]

puts $fd $instr

#addi x4, zero, 1
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd 4 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 1 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]

puts $fd $instr

#jal zero 8(j 8) 
set op [ dict get $opcode "J" ]
set instr [ string replace $instr_J $op_ind_f $op_ind_l $op ]

set rd $zero 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set instr [ string replace $instr $immJ_ind_f $immJ_ind_l 00000001000000000000 ]

#0000_0000_0000_0000_1000
#0_0000001000_000000000

puts $fd $instr

#addi x4, zero, 0
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd 4 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 0 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]

puts $fd $instr

#addi x5, zero, 8 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd 5 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 8 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]

puts $fd $instr

close $fd
