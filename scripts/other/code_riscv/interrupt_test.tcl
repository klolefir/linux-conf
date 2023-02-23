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
set mret_func3 0
set csrrw_func3 1
set csrrs_func3 2
set csrrc_func3 3

set func3_width 3
set func7_width 7
set rs1_width 5
set rs2_width 5
set rd_width 5
set opcode_width 5
set immI_width 12

set mie_addr 772
set mtvec_addr 773
set mscratch_addr 832
set mepc_addr 833
set mcause_addr 834

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
	I_intr 11100
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

set instr_num 14 

#addi gp, zero, instr_num 
set gp 3
set gp_ptr $instr_num
set op [ dict get $opcode "I" ]
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

set imm [ expr $gp_ptr * 4 ] 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#addi sp, zero, 300 
set sp_ptr 100 
set sp 2
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $sp 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm [ expr $sp_ptr * 4 ] 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#addi t0, zero, 11111 
set mie 31
set t0 5 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t0
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm $mie
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#csrrw zero, mie, t0 
set op [ dict get $opcode "I_intr" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $csrrw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $zero
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm $mie_addr
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

set interrupt_ptr 200
#addi t0, zero, interrupt_ptr 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t0 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm [ expr $interrupt_ptr * 4 ] 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#csrrw zero, mtvec, t0 
set op [ dict get $opcode "I_intr" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $csrrw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $zero
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm $mtvec_addr
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr


set mscratch_ptr 250
#addi t0, zero, mscratch_ptr 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t0 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm [ expr $mscratch_ptr * 4 ] 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#csrrw zero, mscratch, t0 
set op [ dict get $opcode "I_intr" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $csrrw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $zero
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm $mscratch_addr
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#addi t0, zero, 1 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t0 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 1
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr
#sw t0, 0(gp)
set op [ dict get $opcode "S" ]
set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

set func3 $sw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $gp
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 $t0
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set imm	0
set imm [ num2bin $imm [ expr 12 - 1 ] ]

set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
incr instr_num
puts $fd $instr


#addi t1, zero, 7 
set t1 6
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t1 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 7
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#addi t2, zero, 8 
set t2 7
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t2 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 8
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#beq x2, zero, 0 

#beq x0, x0, while 
set op [ dict get $opcode "B" ]
set instr [ string replace $instr_B $op_ind_f $op_ind_l $op ]

set func3 $beq_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 $zero 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set instr [ string replace $instr $immB_ind_ff $immB_ind_fl 0000000 ]
set instr [ string replace $instr $immB_ind_lf $immB_ind_ll 00000 ]
incr instr_num

puts $fd $instr

#addi zero, zero, 0 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $zero
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 0
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num
puts $instr_num

puts $fd $instr

set const_width 32
for { set i 1 } { $i < 187 } { incr i } {
	set const 0;
	set const [ num2bin $const $const_width ] 
	puts $fd $const
}

#csrrw t0, mscratch, t0
set op [ dict get $opcode "I_intr" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $csrrw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t0
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm $mscratch_addr
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#sw t1, 0(t0)
set op [ dict get $opcode "S" ]
set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

set func3 $sw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 $t1
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set imm	0
set imm [ num2bin $imm [ expr 12 - 1 ] ]

set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
incr instr_num
puts $fd $instr


#sw t2, 4(t0)
set op [ dict get $opcode "S" ]
set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

set func3 $sw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 $t2
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set imm	4
set imm [ num2bin $imm [ expr 12 - 1 ] ]

set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
incr instr_num
puts $fd $instr


#csrr t1, mcause
#csrrs t1, mcause, x0
set op [ dict get $opcode "I_intr" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $csrrs_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t1 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm $mcause_addr
puts $imm
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
puts $imm
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#TEST
if { 0 } {
#addi t1, zero, 2 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t1
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 2 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr
}


#addi t2, zero, 2 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t2
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 2
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#bne t1, t2, nineteen_ptr 
set nineteen_ptr [ expr 5 * 4 ]
set op [ dict get $opcode "B" ]
set instr [ string replace $instr_B $op_ind_f $op_ind_l $op ]

set func3 $bne_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t1 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 $t2
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

#0000_0001_0100
#0000000_10100

set instr [ string replace $instr $immB_ind_ff $immB_ind_fl 0000000 ]
set instr [ string replace $instr $immB_ind_lf $immB_ind_ll 10100 ]

puts $fd $instr

#lw t2, 0(gp)
set op [ dict get $opcode "I_load" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $lw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $gp
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t2
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 0
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#addi t2, t2, 3 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t2
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t2 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 3
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#sw t2, 0(gp)
set op [ dict get $opcode "S" ]
set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

set func3 $sw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $gp
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 $t2
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set imm	0
set imm [ num2bin $imm [ expr 12 - 1 ] ]

set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
incr instr_num
puts $fd $instr

#jal zero, done_ptr
set done_ptr [ expr 7 * 4 ]
set op [ dict get $opcode "J" ]
set instr [ string replace $instr_J $op_ind_f $op_ind_l $op ]

set rd $zero 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set instr [ string replace $instr $immJ_ind_f $immJ_ind_l 00000001110000000000 ]

#0000_0000_0000_0001_1100
#0_00000_01110_0_00000000

puts $fd $instr


#addi t2, zero, 4 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t2
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 4 
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#bne t1, t2, done_ptr 
set done_ptr [ expr 5 * 4 ]
set op [ dict get $opcode "B" ]
set instr [ string replace $instr_B $op_ind_f $op_ind_l $op ]

set func3 $bne_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t1 
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 $t2 
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

#0000_0001_0100
#0000000_10100

set instr [ string replace $instr $immB_ind_ff $immB_ind_fl 0000000 ]
set instr [ string replace $instr $immB_ind_lf $immB_ind_ll 10100 ]

puts $fd $instr

#lw t2, 0(gp)
set op [ dict get $opcode "I_load" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $lw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $gp
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t2
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 0
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#addi t2, t2, 10 
set op [ dict get $opcode "I" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $addi_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t2
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t2 
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 5
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#sw t2, 0(gp)
set op [ dict get $opcode "S" ]
set instr [ string replace $instr_S $op_ind_f $op_ind_l $op ]

set func3 $sw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $gp
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rs2 $t2
set rs2 [ num2bin $rs2 [ expr $rs2_width - 1  ] ]
set instr [ string replace $instr $rs2_ind_f $rs2_ind_l $rs2 ]

set imm	0
set imm [ num2bin $imm [ expr 12 - 1 ] ]

set instr [ string replace $instr $immS_ind_ff $immS_ind_fl [ string range $imm 0 6 ] ]
set instr [ string replace $instr $immS_ind_lf $immS_ind_ll [string range $imm 7 11 ] ]
incr instr_num
puts $fd $instr

#jal zero, done_ptr
set done_ptr 4
set op [ dict get $opcode "J" ]
set instr [ string replace $instr_J $op_ind_f $op_ind_l $op ]

set rd $zero 
set rd [ num2bin $rd [ expr $rd_width - 1  ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set instr [ string replace $instr $immJ_ind_f $immJ_ind_l 00000000010000000000 ]
#0000_0000_0000_0000_0100
#0_0000000010_0_00000000

puts $fd $instr


#lw t1, 0(t0)
set op [ dict get $opcode "I_load" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $lw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t1
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 0
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#lw t2, 4(t0)
set op [ dict get $opcode "I_load" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $lw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t2
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm 4
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#csrrw t0, mscratch, t0 
set op [ dict get $opcode "I_intr" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $csrrw_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $t0
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $t0
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm $mscratch_addr
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num

puts $fd $instr

#mret
set op [ dict get $opcode "I_intr" ]
set instr [ string replace $instr_I $op_ind_f $op_ind_l $op ]

set func3 $mret_func3
set func3 [ num2bin $func3 [ expr $func3_width - 1  ] ]
set instr [ string replace $instr $func3_ind_f $func3_ind_l $func3 ]

set rs1 $zero
set rs1 [ num2bin $rs1 [ expr $rs1_width - 1  ] ]
set instr [ string replace $instr $rs1_ind_f $rs1_ind_l $rs1 ]

set rd $zero
set rd [ num2bin $rd [ expr $rd_width - 1 ] ]
set instr [ string replace $instr $rd_ind_f $rd_ind_l $rd ]

set imm $zero
set imm [ num2bin $imm [ expr $immI_width - 1  ] ]
set instr [ string replace $instr $immI_ind_f $immI_ind_l $imm ]
incr instr_num


puts $fd $instr

puts $instr_num


