lea sp, stack
add sp, 100000
jmp global_init
recast:
push bp
mov bp, sp
sub sp, 2
mov r1, bp[2] // func_arg:arr
push r1
call len
add sp, 1
mov r1, r0
mov sp[0], r1 // stack_var:arr_len
mov r1, bp[3] // func_arg:start
mov r2, 0
jl r1, r2, builtin_internal_label0
mov r1, 1
jmp builtin_internal_label1
builtin_internal_label0:
mov r1, 0
builtin_internal_label1:
mov r2, bp[3] // func_arg:start
mov r3, sp[0]
jl r2, r3, builtin_internal_label2
mov r2, 0
jmp builtin_internal_label3
builtin_internal_label2:
mov r2, 1
builtin_internal_label3:
je r1, const_zero, builtin_internal_label4
je r2, const_zero, builtin_internal_label4
mov r2, const_one
jmp builtin_internal_label5
builtin_internal_label4:
mov r2, const_zero
builtin_internal_label5:
mov r1, bp[4] // func_arg:end
mov r3, 0
jl r1, r3, builtin_internal_label6
mov r1, 1
jmp builtin_internal_label7
builtin_internal_label6:
mov r1, 0
builtin_internal_label7:
je r2, const_zero, builtin_internal_label8
je r1, const_zero, builtin_internal_label8
mov r1, const_one
jmp builtin_internal_label9
builtin_internal_label8:
mov r1, const_zero
builtin_internal_label9:
mov r2, bp[4] // func_arg:end
mov r3, sp[0]
jl r2, r3, builtin_internal_label10
mov r2, 0
jmp builtin_internal_label11
builtin_internal_label10:
mov r2, 1
builtin_internal_label11:
je r1, const_zero, builtin_internal_label12
je r2, const_zero, builtin_internal_label12
mov r2, const_one
jmp builtin_internal_label13
builtin_internal_label12:
mov r2, const_zero
builtin_internal_label13:
mov r1, bp[3] // func_arg:start
mov r3, bp[4] // func_arg:end
jle r1, r3, builtin_internal_label14
mov r1, 0
jmp builtin_internal_label15
builtin_internal_label14:
mov r1, 1
builtin_internal_label15:
je r2, const_zero, builtin_internal_label16
je r1, const_zero, builtin_internal_label16
mov r1, const_one
jmp builtin_internal_label17
builtin_internal_label16:
mov r1, const_zero
builtin_internal_label17:
je r1, const_zero, builtin_internal_label18
mov r1, bp[4] // func_arg:end
mov r2, bp[3] // func_arg:start
sub r1, r2
mov sp[1], r1 // stack_var:len_of_new_arr
mov r1, bp[2] // func_arg:arr
mov r2, bp[3] // func_arg:start
mov r3, [r1]
jl r3, const_zero, builtin_internal_label21
jl r2, const_zero, builtin_internal_label20
jle r3, r2, builtin_internal_label20
jmp builtin_internal_label22 // range check ok
builtin_internal_label20: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label21: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label22: // range check ok
add r2, 1
add r1, r2
mov r3, sp[1]
mov [r1], r3
mov r3, bp[3] // func_arg:start
push r3
mov r3, bp[2] // func_arg:arr
push r3
call h2occ_core_get_arr_bias
add sp, 2
mov r3, r0
mov r0, r3
jmp recast_func_return
jmp builtin_internal_label19
builtin_internal_label18:
mov r3, 4
sub r1, r1
sub r1, r3
push r1
call h2occ_core_runtime_error
add sp, 1
builtin_internal_label19:
recast_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp, bp
pop bp
retn
exit:
mov r0, sp[1] // exit_code
jmp program_end
exit_func_return:
retn
getchar:
_in_ r0
retn
getchar_func_return:
retn
len:
mov r0, sp[1] // &arr.len
mov r0, [r0] // arr.len
retn
len_func_return:
retn
h2occ_core_no_sign:
push bp
mov bp, sp
sub sp, 1
mov r1, bp[2] // func_arg:num
mov r3, 0
jl r1, r3, builtin_internal_label23
mov r1, 1
jmp builtin_internal_label24
builtin_internal_label23:
mov r1, 0
builtin_internal_label24:
je r1, const_zero, builtin_internal_label26
mov r1, bp[2] // func_arg:num
mov r0, r1
jmp h2occ_core_no_sign_func_return
builtin_internal_label26:
mov r1, 0x7fffffffffffffff
mov r3, 1
add r1, r3
mov sp[0], r1 // stack_var:largest_num
mov r1, bp[2] // func_arg:num
mov r3, sp[0]
add r1, r3
mov r0, r1
jmp h2occ_core_no_sign_func_return
h2occ_core_no_sign_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_with_sign:
push bp
mov bp, sp
sub sp, 1
mov r1, bp[2] // func_arg:num
mov r3, 0
jl r1, r3, builtin_internal_label27
mov r1, 0
jmp builtin_internal_label28
builtin_internal_label27:
mov r1, 1
builtin_internal_label28:
je r1, const_zero, builtin_internal_label30
mov r1, bp[2] // func_arg:num
mov r0, r1
jmp h2occ_core_with_sign_func_return
builtin_internal_label30:
mov r1, 0x7fffffffffffffff
mov r3, 1
add r1, r3
mov sp[0], r1 // stack_var:largest_num
mov r1, bp[2] // func_arg:num
mov r3, sp[0]
sub r1, r3
mov r0, r1
jmp h2occ_core_with_sign_func_return
h2occ_core_with_sign_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_and:
push bp
mov bp, sp
sub sp, 11
mov r1, 0
mov sp[0], r1 // stack_var:sa
mov r1, 0
mov sp[1], r1 // stack_var:sb
mov r1, bp[2] // func_arg:a
mov r3, 0
jl r1, r3, builtin_internal_label31
mov r1, 0
jmp builtin_internal_label32
builtin_internal_label31:
mov r1, 1
builtin_internal_label32:
je r1, const_zero, builtin_internal_label34
lea r1, sp[0]
mov r3, 1
mov [r1], r3
lea r3, bp[2] // &func_arg:a
push r3
mov r1, bp[2] // func_arg:a
push r1
call h2occ_core_no_sign
add sp, 1
pop r3
mov r1, r0
mov [r3], r1
builtin_internal_label34:
mov r1, bp[3] // func_arg:b
mov r3, 0
jl r1, r3, builtin_internal_label35
mov r1, 0
jmp builtin_internal_label36
builtin_internal_label35:
mov r1, 1
builtin_internal_label36:
je r1, const_zero, builtin_internal_label38
lea r1, sp[1]
mov r3, 1
mov [r1], r3
lea r3, bp[3] // &func_arg:b
push r3
mov r1, bp[3] // func_arg:b
push r1
call h2occ_core_no_sign
add sp, 1
pop r3
mov r1, r0
mov [r3], r1
builtin_internal_label38:
mov r1, 0
mov sp[2], r1 // stack_var:result
lea r3, sp[4]
mov sp[3], r3 // the memory stack_var:a_bit points to
mov r1, 1
mov sp[4], r1 // the memory's size
mov r1, 0
mov sp[5], r1 // a_bit[0]
lea r3, sp[7]
mov sp[6], r3 // the memory stack_var:b_bit points to
mov r1, 1
mov sp[7], r1 // the memory's size
mov r1, 0
mov sp[8], r1 // b_bit[0]
mov r1, 1
mov sp[9], r1 // stack_var:mb
mov r1, 0
mov sp[10], r1 // stack_var:i
builtin_internal_label39:
mov r1, sp[10]
mov r3, 63
jl r1, r3, builtin_internal_label41
mov r1, 0
jmp builtin_internal_label42
builtin_internal_label41:
mov r1, 1
builtin_internal_label42:
je r1, const_zero, builtin_internal_label40
mov r1, bp[2] // func_arg:a
mov r3, 0
je r1, r3, builtin_internal_label43
mov r1, 0
jmp builtin_internal_label44
builtin_internal_label43:
mov r1, 1
builtin_internal_label44:
mov r3, bp[3] // func_arg:b
mov r2, 0
je r3, r2, builtin_internal_label45
mov r3, 0
jmp builtin_internal_label46
builtin_internal_label45:
mov r3, 1
builtin_internal_label46:
je r1, const_zero, builtin_internal_label47
mov r2, const_one
jmp builtin_internal_label49
builtin_internal_label47:
je r3, const_zero, builtin_internal_label48
mov r2, const_one
jmp builtin_internal_label49
builtin_internal_label48:
mov r2, const_zero
builtin_internal_label49:
je r2, const_zero, builtin_internal_label51
jmp builtin_loop0_1_break_pos
builtin_internal_label51:
lea r2, bp[2] // &func_arg:a
push r1
push r3
push r2
mov r4, sp[6]
push r4
mov r4, 2
push r4
mov r4, bp[2] // func_arg:a
push r4
call h2occ_core_div_mod
add sp, 3
pop r2
pop r3
pop r1
mov r4, r0
mov [r2], r4
lea r4, bp[3] // &func_arg:b
push r1
push r3
push r4
mov r2, sp[9]
push r2
mov r2, 2
push r2
mov r2, bp[3] // func_arg:b
push r2
call h2occ_core_div_mod
add sp, 3
pop r4
pop r3
pop r1
mov r2, r0
mov [r4], r2
mov r2, sp[3]
mov r4, 0
mov r5, [r2]
jl r5, const_zero, builtin_internal_label53
jl r4, const_zero, builtin_internal_label52
jle r5, r4, builtin_internal_label52
jmp builtin_internal_label54 // range check ok
builtin_internal_label52: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label53: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label54: // range check ok
add r4, 1
add r2, r4
mov r2, [r2]
mov r5, sp[6]
mov r4, 0
mov r6, [r5]
jl r6, const_zero, builtin_internal_label56
jl r4, const_zero, builtin_internal_label55
jle r6, r4, builtin_internal_label55
jmp builtin_internal_label57 // range check ok
builtin_internal_label55: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label56: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label57: // range check ok
add r4, 1
add r5, r4
mov r5, [r5]
je r2, const_zero, builtin_internal_label58
je r5, const_zero, builtin_internal_label58
mov r5, const_one
jmp builtin_internal_label59
builtin_internal_label58:
mov r5, const_zero
builtin_internal_label59:
je r5, const_zero, builtin_internal_label61
lea r5, sp[2]
mov r2, sp[2]
mov r6, sp[9]
add r2, r6
mov [r5], r2
builtin_internal_label61:
lea r2, sp[9]
mov r5, sp[9]
mov r6, sp[9]
add r5, r6
mov [r2], r5
builtin_loop0_1_continue_pos:
lea r5, sp[10]
mov r2, sp[10]
mov r6, 1
add r2, r6
mov [r5], r2
jmp builtin_internal_label39
builtin_internal_label40:
builtin_loop0_1_break_pos:
mov r2, sp[0]
mov r5, sp[1]
je r2, r5, builtin_internal_label62
mov r2, 0
jmp builtin_internal_label63
builtin_internal_label62:
mov r2, 1
builtin_internal_label63:
mov r5, sp[0]
mov r6, 1
je r5, r6, builtin_internal_label64
mov r5, 0
jmp builtin_internal_label65
builtin_internal_label64:
mov r5, 1
builtin_internal_label65:
je r2, const_zero, builtin_internal_label66
je r5, const_zero, builtin_internal_label66
mov r5, const_one
jmp builtin_internal_label67
builtin_internal_label66:
mov r5, const_zero
builtin_internal_label67:
je r5, const_zero, builtin_internal_label69
lea r5, sp[2]
push r1
push r3
push r5
mov r2, sp[5]
push r2
call h2occ_core_with_sign
add sp, 1
pop r5
pop r3
pop r1
mov r2, r0
mov [r5], r2
builtin_internal_label69:
mov r2, sp[2]
mov r0, r2
jmp h2occ_core_and_func_return
h2occ_core_and_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp[5], const_minus_one
mov sp[6], const_minus_one
mov sp[7], const_minus_one
mov sp[8], const_minus_one
mov sp[9], const_minus_one
mov sp[10], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_or:
push bp
mov bp, sp
sub sp, 11
mov r2, 0
mov sp[0], r2 // stack_var:sa
mov r2, 0
mov sp[1], r2 // stack_var:sb
mov r2, bp[2] // func_arg:a
mov r5, 0
jl r2, r5, builtin_internal_label70
mov r2, 0
jmp builtin_internal_label71
builtin_internal_label70:
mov r2, 1
builtin_internal_label71:
je r2, const_zero, builtin_internal_label73
lea r2, sp[0]
mov r5, 1
mov [r2], r5
lea r5, bp[2] // &func_arg:a
push r1
push r3
push r5
mov r2, bp[2] // func_arg:a
push r2
call h2occ_core_no_sign
add sp, 1
pop r5
pop r3
pop r1
mov r2, r0
mov [r5], r2
builtin_internal_label73:
mov r2, bp[3] // func_arg:b
mov r5, 0
jl r2, r5, builtin_internal_label74
mov r2, 0
jmp builtin_internal_label75
builtin_internal_label74:
mov r2, 1
builtin_internal_label75:
je r2, const_zero, builtin_internal_label77
lea r2, sp[1]
mov r5, 1
mov [r2], r5
lea r5, bp[3] // &func_arg:b
push r1
push r3
push r5
mov r2, bp[3] // func_arg:b
push r2
call h2occ_core_no_sign
add sp, 1
pop r5
pop r3
pop r1
mov r2, r0
mov [r5], r2
builtin_internal_label77:
mov r2, 0
mov sp[2], r2 // stack_var:result
lea r5, sp[4]
mov sp[3], r5 // the memory stack_var:a_bit points to
mov r2, 1
mov sp[4], r2 // the memory's size
mov r2, 0
mov sp[5], r2 // a_bit[0]
lea r5, sp[7]
mov sp[6], r5 // the memory stack_var:b_bit points to
mov r2, 1
mov sp[7], r2 // the memory's size
mov r2, 0
mov sp[8], r2 // b_bit[0]
mov r2, 1
mov sp[9], r2 // stack_var:mb
mov r2, 0
mov sp[10], r2 // stack_var:i
builtin_internal_label78:
mov r2, sp[10]
mov r5, 63
jl r2, r5, builtin_internal_label80
mov r2, 0
jmp builtin_internal_label81
builtin_internal_label80:
mov r2, 1
builtin_internal_label81:
je r2, const_zero, builtin_internal_label79
mov r2, bp[2] // func_arg:a
mov r5, 0
je r2, r5, builtin_internal_label82
mov r2, 0
jmp builtin_internal_label83
builtin_internal_label82:
mov r2, 1
builtin_internal_label83:
mov r5, bp[3] // func_arg:b
mov r6, 0
je r5, r6, builtin_internal_label84
mov r5, 0
jmp builtin_internal_label85
builtin_internal_label84:
mov r5, 1
builtin_internal_label85:
je r2, const_zero, builtin_internal_label86
je r5, const_zero, builtin_internal_label86
mov r5, const_one
jmp builtin_internal_label87
builtin_internal_label86:
mov r5, const_zero
builtin_internal_label87:
je r5, const_zero, builtin_internal_label89
jmp builtin_loop1_1_break_pos
builtin_internal_label89:
lea r5, bp[2] // &func_arg:a
push r1
push r3
push r5
mov r2, sp[6]
push r2
mov r2, 2
push r2
mov r2, bp[2] // func_arg:a
push r2
call h2occ_core_div_mod
add sp, 3
pop r5
pop r3
pop r1
mov r2, r0
mov [r5], r2
lea r2, bp[3] // &func_arg:b
push r1
push r3
push r2
mov r5, sp[9]
push r5
mov r5, 2
push r5
mov r5, bp[3] // func_arg:b
push r5
call h2occ_core_div_mod
add sp, 3
pop r2
pop r3
pop r1
mov r5, r0
mov [r2], r5
mov r5, sp[3]
mov r2, 0
mov r6, [r5]
jl r6, const_zero, builtin_internal_label91
jl r2, const_zero, builtin_internal_label90
jle r6, r2, builtin_internal_label90
jmp builtin_internal_label92 // range check ok
builtin_internal_label90: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label91: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label92: // range check ok
add r2, 1
add r5, r2
mov r5, [r5]
mov r6, sp[6]
mov r2, 0
mov r4, [r6]
jl r4, const_zero, builtin_internal_label94
jl r2, const_zero, builtin_internal_label93
jle r4, r2, builtin_internal_label93
jmp builtin_internal_label95 // range check ok
builtin_internal_label93: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label94: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label95: // range check ok
add r2, 1
add r6, r2
mov r6, [r6]
je r5, const_zero, builtin_internal_label96
mov r4, const_one
jmp builtin_internal_label98
builtin_internal_label96:
je r6, const_zero, builtin_internal_label97
mov r4, const_one
jmp builtin_internal_label98
builtin_internal_label97:
mov r4, const_zero
builtin_internal_label98:
je r4, const_zero, builtin_internal_label100
lea r4, sp[2]
mov r2, sp[2]
mov r7, sp[9]
add r2, r7
mov [r4], r2
builtin_internal_label100:
lea r2, sp[9]
mov r4, sp[9]
mov r7, sp[9]
add r4, r7
mov [r2], r4
builtin_loop1_1_continue_pos:
lea r4, sp[10]
mov r2, sp[10]
mov r7, 1
add r2, r7
mov [r4], r2
jmp builtin_internal_label78
builtin_internal_label79:
builtin_loop1_1_break_pos:
mov r2, sp[0]
mov r4, sp[1]
je r2, const_zero, builtin_internal_label101
mov r7, const_one
jmp builtin_internal_label103
builtin_internal_label101:
je r4, const_zero, builtin_internal_label102
mov r7, const_one
jmp builtin_internal_label103
builtin_internal_label102:
mov r7, const_zero
builtin_internal_label103:
je r7, const_zero, builtin_internal_label105
lea r7, sp[2]
push r1
push r3
push r5
push r6
push r2
push r4
push r7
mov r8, sp[9]
push r8
call h2occ_core_with_sign
add sp, 1
pop r7
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov [r7], r8
builtin_internal_label105:
mov r8, sp[2]
mov r0, r8
jmp h2occ_core_or_func_return
h2occ_core_or_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp[5], const_minus_one
mov sp[6], const_minus_one
mov sp[7], const_minus_one
mov sp[8], const_minus_one
mov sp[9], const_minus_one
mov sp[10], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_xor:
push bp
mov bp, sp
sub sp, 11
mov r8, 0
mov sp[0], r8 // stack_var:sa
mov r8, 0
mov sp[1], r8 // stack_var:sb
mov r8, bp[2] // func_arg:a
mov r7, 0
jl r8, r7, builtin_internal_label106
mov r8, 0
jmp builtin_internal_label107
builtin_internal_label106:
mov r8, 1
builtin_internal_label107:
je r8, const_zero, builtin_internal_label109
lea r8, sp[0]
mov r7, 1
mov [r8], r7
lea r7, bp[2] // &func_arg:a
push r1
push r3
push r5
push r6
push r2
push r4
push r7
mov r8, bp[2] // func_arg:a
push r8
call h2occ_core_no_sign
add sp, 1
pop r7
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov [r7], r8
builtin_internal_label109:
mov r8, bp[3] // func_arg:b
mov r7, 0
jl r8, r7, builtin_internal_label110
mov r8, 0
jmp builtin_internal_label111
builtin_internal_label110:
mov r8, 1
builtin_internal_label111:
je r8, const_zero, builtin_internal_label113
lea r8, sp[1]
mov r7, 1
mov [r8], r7
lea r7, bp[3] // &func_arg:b
push r1
push r3
push r5
push r6
push r2
push r4
push r7
mov r8, bp[3] // func_arg:b
push r8
call h2occ_core_no_sign
add sp, 1
pop r7
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov [r7], r8
builtin_internal_label113:
mov r8, 0
mov sp[2], r8 // stack_var:result
lea r7, sp[4]
mov sp[3], r7 // the memory stack_var:a_bit points to
mov r8, 1
mov sp[4], r8 // the memory's size
mov r8, 0
mov sp[5], r8 // a_bit[0]
lea r7, sp[7]
mov sp[6], r7 // the memory stack_var:b_bit points to
mov r8, 1
mov sp[7], r8 // the memory's size
mov r8, 0
mov sp[8], r8 // b_bit[0]
mov r8, 1
mov sp[9], r8 // stack_var:mb
mov r8, 0
mov sp[10], r8 // stack_var:i
builtin_internal_label114:
mov r8, sp[10]
mov r7, 63
jl r8, r7, builtin_internal_label116
mov r8, 0
jmp builtin_internal_label117
builtin_internal_label116:
mov r8, 1
builtin_internal_label117:
je r8, const_zero, builtin_internal_label115
mov r8, bp[2] // func_arg:a
mov r7, 0
je r8, r7, builtin_internal_label118
mov r8, 0
jmp builtin_internal_label119
builtin_internal_label118:
mov r8, 1
builtin_internal_label119:
mov r7, bp[3] // func_arg:b
mov r9, 0
je r7, r9, builtin_internal_label120
mov r7, 0
jmp builtin_internal_label121
builtin_internal_label120:
mov r7, 1
builtin_internal_label121:
je r8, const_zero, builtin_internal_label122
je r7, const_zero, builtin_internal_label122
mov r7, const_one
jmp builtin_internal_label123
builtin_internal_label122:
mov r7, const_zero
builtin_internal_label123:
je r7, const_zero, builtin_internal_label125
jmp builtin_loop2_1_break_pos
builtin_internal_label125:
lea r7, bp[2] // &func_arg:a
push r1
push r3
push r5
push r6
push r2
push r4
push r7
mov r8, sp[10]
push r8
mov r8, 2
push r8
mov r8, bp[2] // func_arg:a
push r8
call h2occ_core_div_mod
add sp, 3
pop r7
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov [r7], r8
lea r8, bp[3] // &func_arg:b
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r7, sp[13]
push r7
mov r7, 2
push r7
mov r7, bp[3] // func_arg:b
push r7
call h2occ_core_div_mod
add sp, 3
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r7, r0
mov [r8], r7
mov r7, sp[3]
mov r8, 0
mov r9, [r7]
jl r9, const_zero, builtin_internal_label127
jl r8, const_zero, builtin_internal_label126
jle r9, r8, builtin_internal_label126
jmp builtin_internal_label128 // range check ok
builtin_internal_label126: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label127: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label128: // range check ok
add r8, 1
add r7, r8
mov r7, [r7]
mov r9, sp[6]
mov r8, 0
mov r11, [r9]
jl r11, const_zero, builtin_internal_label130
jl r8, const_zero, builtin_internal_label129
jle r11, r8, builtin_internal_label129
jmp builtin_internal_label131 // range check ok
builtin_internal_label129: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label130: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label131: // range check ok
add r8, 1
add r9, r8
mov r9, [r9]
je r7, r9, builtin_internal_label132
mov r7, 1
jmp builtin_internal_label133
builtin_internal_label132:
mov r7, 0
builtin_internal_label133:
je r7, const_zero, builtin_internal_label135
lea r7, sp[2]
mov r9, sp[2]
mov r11, sp[9]
add r9, r11
mov [r7], r9
builtin_internal_label135:
lea r9, sp[9]
mov r7, sp[9]
mov r11, sp[9]
add r7, r11
mov [r9], r7
builtin_loop2_1_continue_pos:
lea r7, sp[10]
mov r9, sp[10]
mov r11, 1
add r9, r11
mov [r7], r9
jmp builtin_internal_label114
builtin_internal_label115:
builtin_loop2_1_break_pos:
mov r9, sp[0]
mov r7, sp[1]
je r9, r7, builtin_internal_label136
mov r9, 1
jmp builtin_internal_label137
builtin_internal_label136:
mov r9, 0
builtin_internal_label137:
je r9, const_zero, builtin_internal_label139
lea r9, sp[2]
push r1
push r3
push r5
push r6
push r2
push r4
push r9
mov r7, sp[9]
push r7
call h2occ_core_with_sign
add sp, 1
pop r9
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r7, r0
mov [r9], r7
builtin_internal_label139:
mov r7, sp[2]
mov r0, r7
jmp h2occ_core_xor_func_return
h2occ_core_xor_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp[5], const_minus_one
mov sp[6], const_minus_one
mov sp[7], const_minus_one
mov sp[8], const_minus_one
mov sp[9], const_minus_one
mov sp[10], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_div_mod:
push bp
mov bp, sp
sub sp, 4
mov r7, bp[2] // func_arg:a
mov r9, bp[3] // func_arg:b
jl r7, r9, builtin_internal_label140
mov r7, 0
jmp builtin_internal_label141
builtin_internal_label140:
mov r7, 1
builtin_internal_label141:
je r7, const_zero, builtin_internal_label143
mov r7, bp[4] // func_arg:j
mov r9, 0
mov r11, [r7]
jl r11, const_zero, builtin_internal_label145
jl r9, const_zero, builtin_internal_label144
jle r11, r9, builtin_internal_label144
jmp builtin_internal_label146 // range check ok
builtin_internal_label144: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label145: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label146: // range check ok
add r9, 1
add r7, r9
mov r11, bp[2] // func_arg:a
mov [r7], r11
mov r11, 0
mov r0, r11
jmp h2occ_core_div_mod_func_return
builtin_internal_label143:
mov r11, bp[3] // func_arg:b
mov sp[0], r11 // stack_var:b1
mov r11, 1
mov sp[1], r11 // stack_var:i
mov r11, 0
mov sp[2], r11 // stack_var:bp
mov r11, 0
mov sp[3], r11 // stack_var:ip
builtin_loop3_1_continue_pos:
builtin_internal_label147:
mov r11, 1
je r11, const_zero, builtin_internal_label148
lea r11, sp[2]
mov r7, sp[0]
mov [r11], r7
lea r7, sp[3]
mov r11, sp[1]
mov [r7], r11
lea r11, sp[0]
mov r7, sp[0]
mov r9, sp[0]
add r7, r9
mov [r11], r7
lea r7, sp[1]
mov r11, sp[1]
mov r9, sp[1]
add r11, r9
mov [r7], r11
mov r11, bp[2] // func_arg:a
mov r7, sp[0]
jl r11, r7, builtin_internal_label149
mov r11, 0
jmp builtin_internal_label150
builtin_internal_label149:
mov r11, 1
builtin_internal_label150:
je r11, const_zero, builtin_internal_label152
mov r11, sp[3]
push r1
push r3
push r5
push r6
push r2
push r4
push r11
mov r7, bp[4] // func_arg:j
push r7
mov r7, bp[3] // func_arg:b
push r7
mov r7, bp[2] // func_arg:a
mov r9, sp[11]
sub r7, r9
push r7
call h2occ_core_div_mod
add sp, 3
pop r11
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r7, r0
add r11, r7
mov r0, r11
jmp h2occ_core_div_mod_func_return
builtin_internal_label152:
jmp builtin_internal_label147
builtin_internal_label148:
builtin_loop3_1_break_pos:
h2occ_core_div_mod_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_multr:
push bp
mov bp, sp
sub sp, 5
mov r11, bp[3] // func_arg:b
mov r7, 1
jl r11, r7, builtin_internal_label153
mov r11, 0
jmp builtin_internal_label154
builtin_internal_label153:
mov r11, 1
builtin_internal_label154:
je r11, const_zero, builtin_internal_label156
mov r11, 0
mov r0, r11
jmp h2occ_core_multr_func_return
builtin_internal_label156:
mov r11, bp[3] // func_arg:b
mov r7, 2
jl r11, r7, builtin_internal_label157
mov r11, 0
jmp builtin_internal_label158
builtin_internal_label157:
mov r11, 1
builtin_internal_label158:
je r11, const_zero, builtin_internal_label160
mov r11, bp[2] // func_arg:a
mov r0, r11
jmp h2occ_core_multr_func_return
builtin_internal_label160:
mov r11, 0
mov sp[0], r11 // stack_var:i
lea r7, sp[2]
mov sp[1], r7 // the memory stack_var:j points to
mov r11, 1
mov sp[2], r11 // the memory's size
mov r11, 0
mov sp[3], r11 // j[0]
mov r11, 0
mov sp[4], r11 // stack_var:k
lea r11, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r11
mov r7, sp[8]
push r7
mov r7, 2
push r7
mov r7, bp[3] // func_arg:b
push r7
call h2occ_core_div_mod
add sp, 3
pop r11
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r7, r0
mov [r11], r7
mov r7, sp[1]
mov r11, 0
mov r9, [r7]
jl r9, const_zero, builtin_internal_label162
jl r11, const_zero, builtin_internal_label161
jle r9, r11, builtin_internal_label161
jmp builtin_internal_label163 // range check ok
builtin_internal_label161: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label162: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label163: // range check ok
add r11, 1
add r7, r11
mov r7, [r7]
mov r9, 1
jl r7, r9, builtin_internal_label164
mov r7, 1
jmp builtin_internal_label165
builtin_internal_label164:
mov r7, 0
builtin_internal_label165:
je r7, const_zero, builtin_internal_label167
lea r7, sp[4]
mov r9, bp[2] // func_arg:a
mov [r7], r9
builtin_internal_label167:
push r1
push r3
push r5
push r6
push r2
push r4
mov r9, sp[6]
push r9
mov r9, bp[2] // func_arg:a
mov r7, bp[2] // func_arg:a
add r9, r7
push r9
call h2occ_core_multr
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
mov r7, sp[4]
add r9, r7
mov r0, r9
jmp h2occ_core_multr_func_return
h2occ_core_multr_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_mult:
push bp
mov bp, sp
sub sp, 3
mov r9, 1
mov sp[0], r9 // stack_var:s
mov r9, bp[2] // func_arg:a
mov r7, 0
jl r9, r7, builtin_internal_label168
mov r9, 0
jmp builtin_internal_label169
builtin_internal_label168:
mov r9, 1
builtin_internal_label169:
je r9, const_zero, builtin_internal_label171
lea r9, bp[2] // &func_arg:a
mov r7, bp[2] // func_arg:a
sub r11, r11
sub r11, r7
mov [r9], r11
lea r11, sp[0]
mov r9, sp[0]
sub r7, r7
sub r7, r9
mov [r11], r7
builtin_internal_label171:
mov r7, bp[3] // func_arg:b
mov r11, 0
jl r7, r11, builtin_internal_label172
mov r7, 0
jmp builtin_internal_label173
builtin_internal_label172:
mov r7, 1
builtin_internal_label173:
je r7, const_zero, builtin_internal_label175
lea r7, bp[3] // &func_arg:b
mov r11, bp[3] // func_arg:b
sub r9, r9
sub r9, r11
mov [r7], r9
lea r9, sp[0]
mov r7, sp[0]
sub r11, r11
sub r11, r7
mov [r9], r11
builtin_internal_label175:
mov r11, bp[2] // func_arg:a
mov r9, bp[3] // func_arg:b
jl r11, r9, builtin_internal_label176
mov r11, 0
jmp builtin_internal_label177
builtin_internal_label176:
mov r11, 1
builtin_internal_label177:
je r11, const_zero, builtin_internal_label179
mov r11, bp[2] // func_arg:a
mov sp[1], r11 // stack_var:t
lea r11, bp[2] // &func_arg:a
mov r9, bp[3] // func_arg:b
mov [r11], r9
lea r9, bp[3] // &func_arg:b
mov r11, sp[1]
mov [r9], r11
builtin_internal_label179:
push r1
push r3
push r5
push r6
push r2
push r4
mov r11, bp[3] // func_arg:b
push r11
mov r11, bp[2] // func_arg:a
push r11
call h2occ_core_multr
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
mov sp[2], r11 // stack_var:k
mov r11, sp[0]
mov r9, 0
jle r11, r9, builtin_internal_label180
mov r11, 1
jmp builtin_internal_label181
builtin_internal_label180:
mov r11, 0
builtin_internal_label181:
je r11, const_zero, builtin_internal_label183
mov r11, sp[2]
mov r0, r11
jmp h2occ_core_mult_func_return
builtin_internal_label183:
mov r11, sp[2]
sub r9, r9
sub r9, r11
mov r0, r9
jmp h2occ_core_mult_func_return
h2occ_core_mult_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_print_int:
push bp
mov bp, sp
sub sp, 26
mov r9, bp[2] // func_arg:num
mov r11, 0
jl r9, r11, builtin_internal_label184
mov r9, 0
jmp builtin_internal_label185
builtin_internal_label184:
mov r9, 1
builtin_internal_label185:
je r9, const_zero, builtin_internal_label187
lea r9, bp[2] // &func_arg:num
mov r11, bp[2] // func_arg:num
sub r7, r7
sub r7, r11
mov [r9], r7
mov r7, 45
_out_ r7
builtin_internal_label187:
mov r7, bp[2] // func_arg:num
mov r9, 0
je r7, r9, builtin_internal_label188
mov r7, 0
jmp builtin_internal_label189
builtin_internal_label188:
mov r7, 1
builtin_internal_label189:
je r7, const_zero, builtin_internal_label191
mov r7, 48
_out_ r7
builtin_internal_label191:
lea r9, sp[1]
mov sp[0], r9 // the memory stack_var:parts points to
mov r7, 4
mov sp[1], r7 // the memory's size
mov r7, 0
mov sp[2], r7 // parts[0]
mov r7, 0
mov sp[3], r7 // parts[1]
mov r7, 0
mov sp[4], r7 // parts[2]
mov r7, 0
mov sp[5], r7 // parts[3]
mov r7, bp[2] // func_arg:num
mov sp[6], r7 // stack_var:fir
lea r9, sp[8]
mov sp[7], r9 // the memory stack_var:sec points to
mov r7, 1
mov sp[8], r7 // the memory's size
mov r7, 0
mov sp[9], r7 // sec[0]
mov r7, 0
mov sp[10], r7 // stack_var:i
builtin_internal_label192:
mov r7, sp[10]
mov r9, 4
jl r7, r9, builtin_internal_label194
mov r7, 0
jmp builtin_internal_label195
builtin_internal_label194:
mov r7, 1
builtin_internal_label195:
je r7, const_zero, builtin_internal_label193
lea r7, sp[6]
push r1
push r3
push r5
push r6
push r2
push r4
push r7
mov r9, sp[14]
push r9
mov r9, 100000
push r9
mov r9, sp[15]
push r9
call h2occ_core_div_mod
add sp, 3
pop r7
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
mov [r7], r9
mov r9, sp[0]
mov r7, 3
mov r11, sp[10]
sub r7, r11
mov r11, [r9]
jl r11, const_zero, builtin_internal_label197
jl r7, const_zero, builtin_internal_label196
jle r11, r7, builtin_internal_label196
jmp builtin_internal_label198 // range check ok
builtin_internal_label196: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label197: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label198: // range check ok
add r7, 1
add r9, r7
mov r11, sp[7]
mov r7, 0
mov r8, [r11]
jl r8, const_zero, builtin_internal_label200
jl r7, const_zero, builtin_internal_label199
jle r8, r7, builtin_internal_label199
jmp builtin_internal_label201 // range check ok
builtin_internal_label199: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label200: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label201: // range check ok
add r7, 1
add r11, r7
mov r11, [r11]
mov [r9], r11
builtin_loop4_1_continue_pos:
lea r11, sp[10]
mov r9, sp[10]
mov r8, 1
add r9, r8
mov [r11], r9
jmp builtin_internal_label192
builtin_internal_label193:
builtin_loop4_1_break_pos:
mov r9, 0
mov sp[11], r9 // stack_var:is_mid
mov r9, 0
mov sp[12], r9 // stack_var:i
builtin_internal_label202:
mov r9, sp[12]
mov r11, 4
jl r9, r11, builtin_internal_label204
mov r9, 0
jmp builtin_internal_label205
builtin_internal_label204:
mov r9, 1
builtin_internal_label205:
je r9, const_zero, builtin_internal_label203
mov r9, sp[0]
mov r11, sp[12]
mov r8, [r9]
jl r8, const_zero, builtin_internal_label207
jl r11, const_zero, builtin_internal_label206
jle r8, r11, builtin_internal_label206
jmp builtin_internal_label208 // range check ok
builtin_internal_label206: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label207: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label208: // range check ok
add r11, 1
add r9, r11
mov r9, [r9]
mov r8, 0
je r9, r8, builtin_internal_label209
mov r9, 0
jmp builtin_internal_label210
builtin_internal_label209:
mov r9, 1
builtin_internal_label210:
mov r8, sp[11]
mov r11, 0
je r8, r11, builtin_internal_label211
mov r8, 0
jmp builtin_internal_label212
builtin_internal_label211:
mov r8, 1
builtin_internal_label212:
je r9, const_zero, builtin_internal_label213
je r8, const_zero, builtin_internal_label213
mov r8, const_one
jmp builtin_internal_label214
builtin_internal_label213:
mov r8, const_zero
builtin_internal_label214:
je r8, const_zero, builtin_internal_label216
jmp builtin_loop5_1_continue_pos
builtin_internal_label216:
lea r9, sp[14]
mov sp[13], r9 // the memory stack_var:digits points to
mov r8, 5
mov sp[14], r8 // the memory's size
mov r8, 0
mov sp[15], r8 // digits[0]
mov r8, 0
mov sp[16], r8 // digits[1]
mov r8, 0
mov sp[17], r8 // digits[2]
mov r8, 0
mov sp[18], r8 // digits[3]
mov r8, 0
mov sp[19], r8 // digits[4]
lea r9, sp[21]
mov sp[20], r9 // the memory stack_var:r points to
mov r8, 1
mov sp[21], r8 // the memory's size
mov r8, 0
mov sp[22], r8 // r[0]
mov r8, 0
mov sp[23], r8 // stack_var:i1
mov r8, sp[0]
mov r9, sp[12]
mov r11, [r8]
jl r11, const_zero, builtin_internal_label218
jl r9, const_zero, builtin_internal_label217
jle r11, r9, builtin_internal_label217
jmp builtin_internal_label219 // range check ok
builtin_internal_label217: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label218: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label219: // range check ok
add r9, 1
add r8, r9
mov r8, [r8]
mov sp[24], r8 // stack_var:num
mov r8, sp[11]
je r8, const_zero, builtin_internal_label220
mov r8, 0
mov sp[25], r8 // stack_var:i
builtin_internal_label222:
mov r8, sp[25]
mov r11, 5
jl r8, r11, builtin_internal_label224
mov r8, 0
jmp builtin_internal_label225
builtin_internal_label224:
mov r8, 1
builtin_internal_label225:
je r8, const_zero, builtin_internal_label223
lea r8, sp[24]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r11, sp[27]
push r11
mov r11, 10
push r11
mov r11, sp[33]
push r11
call h2occ_core_div_mod
add sp, 3
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
mov [r8], r11
mov r11, sp[13]
mov r8, sp[25]
mov r9, [r11]
jl r9, const_zero, builtin_internal_label227
jl r8, const_zero, builtin_internal_label226
jle r9, r8, builtin_internal_label226
jmp builtin_internal_label228 // range check ok
builtin_internal_label226: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label227: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label228: // range check ok
add r8, 1
add r11, r8
mov r9, 0x30
mov r8, sp[20]
mov r7, 0
mov r12, [r8]
jl r12, const_zero, builtin_internal_label230
jl r7, const_zero, builtin_internal_label229
jle r12, r7, builtin_internal_label229
jmp builtin_internal_label231 // range check ok
builtin_internal_label229: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label230: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label231: // range check ok
add r7, 1
add r8, r7
mov r8, [r8]
add r9, r8
mov [r11], r9
builtin_loop6_1_continue_pos:
lea r9, sp[25]
mov r11, sp[25]
mov r8, 1
add r11, r8
mov [r9], r11
jmp builtin_internal_label222
builtin_internal_label223:
builtin_loop6_1_break_pos:
lea r11, sp[23]
mov r9, 4
mov [r11], r9
jmp builtin_internal_label221
builtin_internal_label220:
builtin_loop7_1_continue_pos:
builtin_internal_label232:
lea r9, sp[24]
push r1
push r3
push r5
push r6
push r2
push r4
push r9
mov r11, sp[27]
push r11
mov r11, 10
push r11
mov r11, sp[33]
push r11
call h2occ_core_div_mod
add sp, 3
pop r9
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
mov [r9], r11
je r11, const_zero, builtin_internal_label233
mov r11, sp[13]
mov r9, sp[23]
mov r8, [r11]
jl r8, const_zero, builtin_internal_label235
jl r9, const_zero, builtin_internal_label234
jle r8, r9, builtin_internal_label234
jmp builtin_internal_label236 // range check ok
builtin_internal_label234: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label235: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label236: // range check ok
add r9, 1
add r11, r9
mov r8, 0x30
mov r9, sp[20]
mov r12, 0
mov r7, [r9]
jl r7, const_zero, builtin_internal_label238
jl r12, const_zero, builtin_internal_label237
jle r7, r12, builtin_internal_label237
jmp builtin_internal_label239 // range check ok
builtin_internal_label237: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label238: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label239: // range check ok
add r12, 1
add r9, r12
mov r9, [r9]
add r8, r9
mov [r11], r8
lea r8, sp[23]
mov r11, sp[23]
mov r9, 1
add r11, r9
mov [r8], r11
jmp builtin_internal_label232
builtin_internal_label233:
builtin_loop7_1_break_pos:
mov r11, sp[13]
mov r8, sp[23]
mov r9, [r11]
jl r9, const_zero, builtin_internal_label241
jl r8, const_zero, builtin_internal_label240
jle r9, r8, builtin_internal_label240
jmp builtin_internal_label242 // range check ok
builtin_internal_label240: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label241: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label242: // range check ok
add r8, 1
add r11, r8
mov r9, 0x30
mov r8, sp[20]
mov r7, 0
mov r12, [r8]
jl r12, const_zero, builtin_internal_label244
jl r7, const_zero, builtin_internal_label243
jle r12, r7, builtin_internal_label243
jmp builtin_internal_label245 // range check ok
builtin_internal_label243: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label244: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label245: // range check ok
add r7, 1
add r8, r7
mov r8, [r8]
add r9, r8
mov [r11], r9
builtin_internal_label221:
builtin_loop8_1_continue_pos:
builtin_internal_label246:
mov r9, sp[23]
mov r11, 0
jl r9, r11, builtin_internal_label248
mov r9, 1
jmp builtin_internal_label249
builtin_internal_label248:
mov r9, 0
builtin_internal_label249:
je r9, const_zero, builtin_internal_label247
mov r9, sp[13]
mov r11, sp[23]
mov r8, [r9]
jl r8, const_zero, builtin_internal_label251
jl r11, const_zero, builtin_internal_label250
jle r8, r11, builtin_internal_label250
jmp builtin_internal_label252 // range check ok
builtin_internal_label250: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label251: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label252: // range check ok
add r11, 1
add r9, r11
mov r9, [r9]
_out_ r9
lea r9, sp[23]
mov r8, sp[23]
mov r11, 1
sub r8, r11
mov [r9], r8
jmp builtin_internal_label246
builtin_internal_label247:
builtin_loop8_1_break_pos:
lea r8, sp[11]
mov r9, 1
mov [r8], r9
builtin_loop5_1_continue_pos:
lea r9, sp[12]
mov r8, sp[12]
mov r11, 1
add r8, r11
mov [r9], r8
jmp builtin_internal_label202
builtin_internal_label203:
builtin_loop5_1_break_pos:
h2occ_core_print_int_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp[5], const_minus_one
mov sp[6], const_minus_one
mov sp[7], const_minus_one
mov sp[8], const_minus_one
mov sp[9], const_minus_one
mov sp[10], const_minus_one
mov sp[11], const_minus_one
mov sp[12], const_minus_one
mov sp[13], const_minus_one
mov sp[14], const_minus_one
mov sp[15], const_minus_one
mov sp[16], const_minus_one
mov sp[17], const_minus_one
mov sp[18], const_minus_one
mov sp[19], const_minus_one
mov sp[20], const_minus_one
mov sp[21], const_minus_one
mov sp[22], const_minus_one
mov sp[23], const_minus_one
mov sp[24], const_minus_one
mov sp[25], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_runtime_error:
push bp
mov bp, sp
sub sp, 157
mov r8, bp[2] // func_arg:err_code
mov r9, 2
sub r11, r11
sub r11, r9
je r8, r11, builtin_internal_label253
mov r8, 0
jmp builtin_internal_label254
builtin_internal_label253:
mov r8, 1
builtin_internal_label254:
je r8, const_zero, builtin_internal_label255
lea r11, sp[1]
mov sp[0], r11 // the memory stack_var:msg points to
mov r8, 42
mov sp[1], r8 // the memory's size
mov r8, 10
mov sp[2], r8 // msg[0]
mov r8, 82
mov sp[3], r8 // msg[1]
mov r8, 117
mov sp[4], r8 // msg[2]
mov r8, 110
mov sp[5], r8 // msg[3]
mov r8, 116
mov sp[6], r8 // msg[4]
mov r8, 105
mov sp[7], r8 // msg[5]
mov r8, 109
mov sp[8], r8 // msg[6]
mov r8, 101
mov sp[9], r8 // msg[7]
mov r8, 32
mov sp[10], r8 // msg[8]
mov r8, 101
mov sp[11], r8 // msg[9]
mov r8, 114
mov sp[12], r8 // msg[10]
mov r8, 114
mov sp[13], r8 // msg[11]
mov r8, 111
mov sp[14], r8 // msg[12]
mov r8, 114
mov sp[15], r8 // msg[13]
mov r8, 58
mov sp[16], r8 // msg[14]
mov r8, 32
mov sp[17], r8 // msg[15]
mov r8, 65
mov sp[18], r8 // msg[16]
mov r8, 114
mov sp[19], r8 // msg[17]
mov r8, 114
mov sp[20], r8 // msg[18]
mov r8, 97
mov sp[21], r8 // msg[19]
mov r8, 121
mov sp[22], r8 // msg[20]
mov r8, 32
mov sp[23], r8 // msg[21]
mov r8, 105
mov sp[24], r8 // msg[22]
mov r8, 110
mov sp[25], r8 // msg[23]
mov r8, 100
mov sp[26], r8 // msg[24]
mov r8, 101
mov sp[27], r8 // msg[25]
mov r8, 120
mov sp[28], r8 // msg[26]
mov r8, 32
mov sp[29], r8 // msg[27]
mov r8, 111
mov sp[30], r8 // msg[28]
mov r8, 117
mov sp[31], r8 // msg[29]
mov r8, 116
mov sp[32], r8 // msg[30]
mov r8, 32
mov sp[33], r8 // msg[31]
mov r8, 111
mov sp[34], r8 // msg[32]
mov r8, 102
mov sp[35], r8 // msg[33]
mov r8, 32
mov sp[36], r8 // msg[34]
mov r8, 98
mov sp[37], r8 // msg[35]
mov r8, 111
mov sp[38], r8 // msg[36]
mov r8, 117
mov sp[39], r8 // msg[37]
mov r8, 110
mov sp[40], r8 // msg[38]
mov r8, 100
mov sp[41], r8 // msg[39]
mov r8, 115
mov sp[42], r8 // msg[40]
mov r8, 10
mov sp[43], r8 // msg[41]
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, sp[6]
push r8
call h2occ_core_print_str
add sp, 1
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
jmp builtin_internal_label256
builtin_internal_label255:
mov r8, bp[2] // func_arg:err_code
mov r11, 3
sub r9, r9
sub r9, r11
je r8, r9, builtin_internal_label257
mov r8, 0
jmp builtin_internal_label258
builtin_internal_label257:
mov r8, 1
builtin_internal_label258:
je r8, const_zero, builtin_internal_label259
lea r9, sp[45]
mov sp[44], r9 // the memory stack_var:msg points to
mov r8, 47
mov sp[45], r8 // the memory's size
mov r8, 10
mov sp[46], r8 // msg[0]
mov r8, 82
mov sp[47], r8 // msg[1]
mov r8, 117
mov sp[48], r8 // msg[2]
mov r8, 110
mov sp[49], r8 // msg[3]
mov r8, 116
mov sp[50], r8 // msg[4]
mov r8, 105
mov sp[51], r8 // msg[5]
mov r8, 109
mov sp[52], r8 // msg[6]
mov r8, 101
mov sp[53], r8 // msg[7]
mov r8, 32
mov sp[54], r8 // msg[8]
mov r8, 101
mov sp[55], r8 // msg[9]
mov r8, 114
mov sp[56], r8 // msg[10]
mov r8, 114
mov sp[57], r8 // msg[11]
mov r8, 111
mov sp[58], r8 // msg[12]
mov r8, 114
mov sp[59], r8 // msg[13]
mov r8, 58
mov sp[60], r8 // msg[14]
mov r8, 32
mov sp[61], r8 // msg[15]
mov r8, 85
mov sp[62], r8 // msg[16]
mov r8, 115
mov sp[63], r8 // msg[17]
mov r8, 101
mov sp[64], r8 // msg[18]
mov r8, 32
mov sp[65], r8 // msg[19]
mov r8, 111
mov sp[66], r8 // msg[20]
mov r8, 102
mov sp[67], r8 // msg[21]
mov r8, 32
mov sp[68], r8 // msg[22]
mov r8, 97
mov sp[69], r8 // msg[23]
mov r8, 110
mov sp[70], r8 // msg[24]
mov r8, 32
mov sp[71], r8 // msg[25]
mov r8, 117
mov sp[72], r8 // msg[26]
mov r8, 110
mov sp[73], r8 // msg[27]
mov r8, 105
mov sp[74], r8 // msg[28]
mov r8, 110
mov sp[75], r8 // msg[29]
mov r8, 105
mov sp[76], r8 // msg[30]
mov r8, 116
mov sp[77], r8 // msg[31]
mov r8, 105
mov sp[78], r8 // msg[32]
mov r8, 97
mov sp[79], r8 // msg[33]
mov r8, 108
mov sp[80], r8 // msg[34]
mov r8, 105
mov sp[81], r8 // msg[35]
mov r8, 122
mov sp[82], r8 // msg[36]
mov r8, 101
mov sp[83], r8 // msg[37]
mov r8, 100
mov sp[84], r8 // msg[38]
mov r8, 32
mov sp[85], r8 // msg[39]
mov r8, 109
mov sp[86], r8 // msg[40]
mov r8, 101
mov sp[87], r8 // msg[41]
mov r8, 109
mov sp[88], r8 // msg[42]
mov r8, 111
mov sp[89], r8 // msg[43]
mov r8, 114
mov sp[90], r8 // msg[44]
mov r8, 121
mov sp[91], r8 // msg[45]
mov r8, 10
mov sp[92], r8 // msg[46]
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, sp[50]
push r8
call h2occ_core_print_str
add sp, 1
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
jmp builtin_internal_label260
builtin_internal_label259:
mov r8, bp[2] // func_arg:err_code
mov r9, 4
sub r11, r11
sub r11, r9
je r8, r11, builtin_internal_label261
mov r8, 0
jmp builtin_internal_label262
builtin_internal_label261:
mov r8, 1
builtin_internal_label262:
je r8, const_zero, builtin_internal_label263
lea r11, sp[94]
mov sp[93], r11 // the memory stack_var:msg points to
mov r8, 37
mov sp[94], r8 // the memory's size
mov r8, 10
mov sp[95], r8 // msg[0]
mov r8, 82
mov sp[96], r8 // msg[1]
mov r8, 117
mov sp[97], r8 // msg[2]
mov r8, 110
mov sp[98], r8 // msg[3]
mov r8, 116
mov sp[99], r8 // msg[4]
mov r8, 105
mov sp[100], r8 // msg[5]
mov r8, 109
mov sp[101], r8 // msg[6]
mov r8, 101
mov sp[102], r8 // msg[7]
mov r8, 32
mov sp[103], r8 // msg[8]
mov r8, 101
mov sp[104], r8 // msg[9]
mov r8, 114
mov sp[105], r8 // msg[10]
mov r8, 114
mov sp[106], r8 // msg[11]
mov r8, 111
mov sp[107], r8 // msg[12]
mov r8, 114
mov sp[108], r8 // msg[13]
mov r8, 58
mov sp[109], r8 // msg[14]
mov r8, 32
mov sp[110], r8 // msg[15]
mov r8, 73
mov sp[111], r8 // msg[16]
mov r8, 110
mov sp[112], r8 // msg[17]
mov r8, 118
mov sp[113], r8 // msg[18]
mov r8, 97
mov sp[114], r8 // msg[19]
mov r8, 108
mov sp[115], r8 // msg[20]
mov r8, 105
mov sp[116], r8 // msg[21]
mov r8, 100
mov sp[117], r8 // msg[22]
mov r8, 32
mov sp[118], r8 // msg[23]
mov r8, 97
mov sp[119], r8 // msg[24]
mov r8, 114
mov sp[120], r8 // msg[25]
mov r8, 114
mov sp[121], r8 // msg[26]
mov r8, 97
mov sp[122], r8 // msg[27]
mov r8, 121
mov sp[123], r8 // msg[28]
mov r8, 32
mov sp[124], r8 // msg[29]
mov r8, 114
mov sp[125], r8 // msg[30]
mov r8, 101
mov sp[126], r8 // msg[31]
mov r8, 99
mov sp[127], r8 // msg[32]
mov r8, 97
mov sp[128], r8 // msg[33]
mov r8, 115
mov sp[129], r8 // msg[34]
mov r8, 116
mov sp[130], r8 // msg[35]
mov r8, 10
mov sp[131], r8 // msg[36]
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, sp[99]
push r8
call h2occ_core_print_str
add sp, 1
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
jmp builtin_internal_label264
builtin_internal_label263:
lea r11, sp[133]
mov sp[132], r11 // the memory stack_var:msg points to
mov r8, 23
mov sp[133], r8 // the memory's size
mov r8, 10
mov sp[134], r8 // msg[0]
mov r8, 85
mov sp[135], r8 // msg[1]
mov r8, 110
mov sp[136], r8 // msg[2]
mov r8, 107
mov sp[137], r8 // msg[3]
mov r8, 110
mov sp[138], r8 // msg[4]
mov r8, 111
mov sp[139], r8 // msg[5]
mov r8, 119
mov sp[140], r8 // msg[6]
mov r8, 110
mov sp[141], r8 // msg[7]
mov r8, 32
mov sp[142], r8 // msg[8]
mov r8, 114
mov sp[143], r8 // msg[9]
mov r8, 117
mov sp[144], r8 // msg[10]
mov r8, 110
mov sp[145], r8 // msg[11]
mov r8, 116
mov sp[146], r8 // msg[12]
mov r8, 105
mov sp[147], r8 // msg[13]
mov r8, 109
mov sp[148], r8 // msg[14]
mov r8, 101
mov sp[149], r8 // msg[15]
mov r8, 32
mov sp[150], r8 // msg[16]
mov r8, 101
mov sp[151], r8 // msg[17]
mov r8, 114
mov sp[152], r8 // msg[18]
mov r8, 114
mov sp[153], r8 // msg[19]
mov r8, 111
mov sp[154], r8 // msg[20]
mov r8, 114
mov sp[155], r8 // msg[21]
mov r8, 10
mov sp[156], r8 // msg[22]
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, sp[138]
push r8
call h2occ_core_print_str
add sp, 1
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
builtin_internal_label264:
builtin_internal_label260:
builtin_internal_label256:
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, bp[2] // func_arg:err_code
push r8
call exit
add sp, 1
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
h2occ_core_runtime_error_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp[5], const_minus_one
mov sp[6], const_minus_one
mov sp[7], const_minus_one
mov sp[8], const_minus_one
mov sp[9], const_minus_one
mov sp[10], const_minus_one
mov sp[11], const_minus_one
mov sp[12], const_minus_one
mov sp[13], const_minus_one
mov sp[14], const_minus_one
mov sp[15], const_minus_one
mov sp[16], const_minus_one
mov sp[17], const_minus_one
mov sp[18], const_minus_one
mov sp[19], const_minus_one
mov sp[20], const_minus_one
mov sp[21], const_minus_one
mov sp[22], const_minus_one
mov sp[23], const_minus_one
mov sp[24], const_minus_one
mov sp[25], const_minus_one
mov sp[26], const_minus_one
mov sp[27], const_minus_one
mov sp[28], const_minus_one
mov sp[29], const_minus_one
mov sp[30], const_minus_one
mov sp[31], const_minus_one
mov sp[32], const_minus_one
mov sp[33], const_minus_one
mov sp[34], const_minus_one
mov sp[35], const_minus_one
mov sp[36], const_minus_one
mov sp[37], const_minus_one
mov sp[38], const_minus_one
mov sp[39], const_minus_one
mov sp[40], const_minus_one
mov sp[41], const_minus_one
mov sp[42], const_minus_one
mov sp[43], const_minus_one
mov sp[44], const_minus_one
mov sp[45], const_minus_one
mov sp[46], const_minus_one
mov sp[47], const_minus_one
mov sp[48], const_minus_one
mov sp[49], const_minus_one
mov sp[50], const_minus_one
mov sp[51], const_minus_one
mov sp[52], const_minus_one
mov sp[53], const_minus_one
mov sp[54], const_minus_one
mov sp[55], const_minus_one
mov sp[56], const_minus_one
mov sp[57], const_minus_one
mov sp[58], const_minus_one
mov sp[59], const_minus_one
mov sp[60], const_minus_one
mov sp[61], const_minus_one
mov sp[62], const_minus_one
mov sp[63], const_minus_one
mov sp[64], const_minus_one
mov sp[65], const_minus_one
mov sp[66], const_minus_one
mov sp[67], const_minus_one
mov sp[68], const_minus_one
mov sp[69], const_minus_one
mov sp[70], const_minus_one
mov sp[71], const_minus_one
mov sp[72], const_minus_one
mov sp[73], const_minus_one
mov sp[74], const_minus_one
mov sp[75], const_minus_one
mov sp[76], const_minus_one
mov sp[77], const_minus_one
mov sp[78], const_minus_one
mov sp[79], const_minus_one
mov sp[80], const_minus_one
mov sp[81], const_minus_one
mov sp[82], const_minus_one
mov sp[83], const_minus_one
mov sp[84], const_minus_one
mov sp[85], const_minus_one
mov sp[86], const_minus_one
mov sp[87], const_minus_one
mov sp[88], const_minus_one
mov sp[89], const_minus_one
mov sp[90], const_minus_one
mov sp[91], const_minus_one
mov sp[92], const_minus_one
mov sp[93], const_minus_one
mov sp[94], const_minus_one
mov sp[95], const_minus_one
mov sp[96], const_minus_one
mov sp[97], const_minus_one
mov sp[98], const_minus_one
mov sp[99], const_minus_one
mov sp[100], const_minus_one
mov sp[101], const_minus_one
mov sp[102], const_minus_one
mov sp[103], const_minus_one
mov sp[104], const_minus_one
mov sp[105], const_minus_one
mov sp[106], const_minus_one
mov sp[107], const_minus_one
mov sp[108], const_minus_one
mov sp[109], const_minus_one
mov sp[110], const_minus_one
mov sp[111], const_minus_one
mov sp[112], const_minus_one
mov sp[113], const_minus_one
mov sp[114], const_minus_one
mov sp[115], const_minus_one
mov sp[116], const_minus_one
mov sp[117], const_minus_one
mov sp[118], const_minus_one
mov sp[119], const_minus_one
mov sp[120], const_minus_one
mov sp[121], const_minus_one
mov sp[122], const_minus_one
mov sp[123], const_minus_one
mov sp[124], const_minus_one
mov sp[125], const_minus_one
mov sp[126], const_minus_one
mov sp[127], const_minus_one
mov sp[128], const_minus_one
mov sp[129], const_minus_one
mov sp[130], const_minus_one
mov sp[131], const_minus_one
mov sp[132], const_minus_one
mov sp[133], const_minus_one
mov sp[134], const_minus_one
mov sp[135], const_minus_one
mov sp[136], const_minus_one
mov sp[137], const_minus_one
mov sp[138], const_minus_one
mov sp[139], const_minus_one
mov sp[140], const_minus_one
mov sp[141], const_minus_one
mov sp[142], const_minus_one
mov sp[143], const_minus_one
mov sp[144], const_minus_one
mov sp[145], const_minus_one
mov sp[146], const_minus_one
mov sp[147], const_minus_one
mov sp[148], const_minus_one
mov sp[149], const_minus_one
mov sp[150], const_minus_one
mov sp[151], const_minus_one
mov sp[152], const_minus_one
mov sp[153], const_minus_one
mov sp[154], const_minus_one
mov sp[155], const_minus_one
mov sp[156], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_print_str:
push bp
mov bp, sp
sub sp, 1
mov r8, 0
mov sp[0], r8 // stack_var:i
builtin_internal_label265:
mov r8, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r11, bp[2] // func_arg:message
push r11
call len
add sp, 1
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
jl r8, r11, builtin_internal_label267
mov r8, 0
jmp builtin_internal_label268
builtin_internal_label267:
mov r8, 1
builtin_internal_label268:
je r8, const_zero, builtin_internal_label266
mov r8, bp[2] // func_arg:message
mov r11, sp[0]
mov r9, [r8]
jl r9, const_zero, builtin_internal_label270
jl r11, const_zero, builtin_internal_label269
jle r9, r11, builtin_internal_label269
jmp builtin_internal_label271 // range check ok
builtin_internal_label269: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label270: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label271: // range check ok
add r11, 1
add r8, r11
mov r8, [r8]
_out_ r8
builtin_loop9_1_continue_pos:
lea r8, sp[0]
mov r9, sp[0]
mov r11, 1
add r9, r11
mov [r8], r9
jmp builtin_internal_label265
builtin_internal_label266:
builtin_loop9_1_break_pos:
h2occ_core_print_str_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_div:
push bp
mov bp, sp
sub sp, 4
mov r9, 1
mov sp[0], r9 // stack_var:s
mov r9, bp[2] // func_arg:a
mov r8, 0
jl r9, r8, builtin_internal_label272
mov r9, 0
jmp builtin_internal_label273
builtin_internal_label272:
mov r9, 1
builtin_internal_label273:
je r9, const_zero, builtin_internal_label275
lea r9, bp[2] // &func_arg:a
mov r8, bp[2] // func_arg:a
sub r11, r11
sub r11, r8
mov [r9], r11
lea r11, sp[0]
mov r9, sp[0]
sub r8, r8
sub r8, r9
mov [r11], r8
builtin_internal_label275:
mov r8, bp[3] // func_arg:b
mov r11, 0
jl r8, r11, builtin_internal_label276
mov r8, 0
jmp builtin_internal_label277
builtin_internal_label276:
mov r8, 1
builtin_internal_label277:
je r8, const_zero, builtin_internal_label279
lea r8, bp[3] // &func_arg:b
mov r11, bp[3] // func_arg:b
sub r9, r9
sub r9, r11
mov [r8], r9
lea r9, sp[0]
mov r8, sp[0]
sub r11, r11
sub r11, r8
mov [r9], r11
builtin_internal_label279:
lea r9, sp[2]
mov sp[1], r9 // the memory stack_var:tmp points to
mov r11, 1
mov sp[2], r11 // the memory's size
mov r11, 0
mov sp[3], r11 // tmp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r1
push r3
push r5
push r6
push r2
push r4
mov r11, sp[13]
push r11
mov r11, bp[3] // func_arg:b
push r11
mov r11, bp[2] // func_arg:a
push r11
call h2occ_core_div_mod
add sp, 3
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
push r11
mov r11, sp[7]
push r11
call h2occ_core_mult
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
mov r0, r11
jmp h2occ_core_div_func_return
h2occ_core_div_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_mod:
push bp
mov bp, sp
sub sp, 4
mov r11, 1
mov sp[0], r11 // stack_var:s
mov r11, bp[2] // func_arg:a
mov r9, 0
jl r11, r9, builtin_internal_label280
mov r11, 0
jmp builtin_internal_label281
builtin_internal_label280:
mov r11, 1
builtin_internal_label281:
je r11, const_zero, builtin_internal_label283
lea r11, bp[2] // &func_arg:a
mov r9, bp[2] // func_arg:a
sub r8, r8
sub r8, r9
mov [r11], r8
lea r8, sp[0]
mov r11, sp[0]
sub r9, r9
sub r9, r11
mov [r8], r9
builtin_internal_label283:
mov r9, bp[3] // func_arg:b
mov r8, 0
jl r9, r8, builtin_internal_label284
mov r9, 0
jmp builtin_internal_label285
builtin_internal_label284:
mov r9, 1
builtin_internal_label285:
je r9, const_zero, builtin_internal_label287
lea r9, bp[3] // &func_arg:b
mov r8, bp[3] // func_arg:b
sub r11, r11
sub r11, r8
mov [r9], r11
lea r11, sp[0]
mov r9, sp[0]
sub r8, r8
sub r8, r9
mov [r11], r8
builtin_internal_label287:
lea r11, sp[2]
mov sp[1], r11 // the memory stack_var:r points to
mov r8, 1
mov sp[2], r8 // the memory's size
mov r8, 0
mov sp[3], r8 // r[0]
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, sp[7]
push r8
mov r8, bp[3] // func_arg:b
push r8
mov r8, bp[2] // func_arg:a
push r8
call h2occ_core_div_mod
add sp, 3
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, sp[7]
mov r11, 0
mov r9, [r8]
jl r9, const_zero, builtin_internal_label289
jl r11, const_zero, builtin_internal_label288
jle r9, r11, builtin_internal_label288
jmp builtin_internal_label290 // range check ok
builtin_internal_label288: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label289: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label290: // range check ok
add r11, 1
add r8, r11
mov r8, [r8]
push r8
mov r8, sp[7]
push r8
call h2occ_core_mult
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov r0, r8
jmp h2occ_core_mod_func_return
h2occ_core_mod_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp, bp
pop bp
retn
h2occ_core_get_arr_bias:
mov r0, sp[1] // arr
mov r1, sp[2] // bias
add r0, r1
add r0, 1
retn
h2occ_core_get_arr_bias_func_return:
retn
lshift32:
push bp
mov bp, sp
sub sp, 1
mov r8, 0
mov sp[0], r8 // stack_var:i
builtin_internal_label291:
mov r8, sp[0]
mov r9, bp[3] // func_arg:shift
jl r8, r9, builtin_internal_label293
mov r8, 0
jmp builtin_internal_label294
builtin_internal_label293:
mov r8, 1
builtin_internal_label294:
je r8, const_zero, builtin_internal_label292
lea r8, bp[2] // &func_arg:v
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r9, 2
push r9
mov r9, bp[2] // func_arg:v
push r9
call h2occ_core_mult
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
mov [r8], r9
builtin_loop0_0_continue_pos:
lea r9, sp[0]
mov r8, sp[0]
mov r11, 1
add r8, r11
mov [r9], r8
jmp builtin_internal_label291
builtin_internal_label292:
builtin_loop0_0_break_pos:
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, 0x100000000
push r8
mov r8, bp[2] // func_arg:v
push r8
call h2occ_core_mod
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov r0, r8
jmp lshift32_func_return
lshift32_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp, bp
pop bp
retn
rshift32:
push bp
mov bp, sp
sub sp, 1
mov r8, 0
mov sp[0], r8 // stack_var:i
builtin_internal_label295:
mov r8, sp[0]
mov r9, bp[3] // func_arg:shift
jl r8, r9, builtin_internal_label297
mov r8, 0
jmp builtin_internal_label298
builtin_internal_label297:
mov r8, 1
builtin_internal_label298:
je r8, const_zero, builtin_internal_label296
lea r8, bp[2] // &func_arg:v
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r9, 2
push r9
mov r9, bp[2] // func_arg:v
push r9
call h2occ_core_div
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
mov [r8], r9
builtin_loop1_0_continue_pos:
lea r9, sp[0]
mov r8, sp[0]
mov r11, 1
add r8, r11
mov [r9], r8
jmp builtin_internal_label295
builtin_internal_label296:
builtin_loop1_0_break_pos:
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, 0x100000000
push r8
mov r8, bp[2] // func_arg:v
push r8
call h2occ_core_mod
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov r0, r8
jmp rshift32_func_return
rshift32_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp, bp
pop bp
retn
encipher:
push bp
mov bp, sp
sub sp, 7
mov r8, bp[3] // func_arg:v
mov r9, 0
mov r11, [r8]
jl r11, const_zero, builtin_internal_label300
jl r9, const_zero, builtin_internal_label299
jle r11, r9, builtin_internal_label299
jmp builtin_internal_label301 // range check ok
builtin_internal_label299: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label300: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label301: // range check ok
add r9, 1
add r8, r9
mov r8, [r8]
mov sp[0], r8 // stack_var:v0
mov r8, bp[3] // func_arg:v
mov r11, 1
mov r9, [r8]
jl r9, const_zero, builtin_internal_label303
jl r11, const_zero, builtin_internal_label302
jle r9, r11, builtin_internal_label302
jmp builtin_internal_label304 // range check ok
builtin_internal_label302: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label303: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label304: // range check ok
add r11, 1
add r8, r11
mov r8, [r8]
mov sp[1], r8 // stack_var:v1
mov r8, 0
mov sp[2], r8 // stack_var:sum
mov r8, 0x636f3268
mov sp[3], r8 // stack_var:delta
mov r8, 0
mov sp[4], r8 // stack_var:i
builtin_internal_label305:
mov r8, sp[4]
mov r9, bp[2] // func_arg:num_rounds
jl r8, r9, builtin_internal_label307
mov r8, 0
jmp builtin_internal_label308
builtin_internal_label307:
mov r8, 1
builtin_internal_label308:
je r8, const_zero, builtin_internal_label306
lea r8, sp[0]
mov r9, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r9
mov r11, sp[10]
mov r12, bp[4] // func_arg:key
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r9
push r11
push r12
mov r7, 4
push r7
mov r7, sp[21]
push r7
call h2occ_core_mod
add sp, 2
pop r12
pop r11
pop r9
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r7, r0
mov r13, [r12]
jl r13, const_zero, builtin_internal_label310
jl r7, const_zero, builtin_internal_label309
jle r13, r7, builtin_internal_label309
jmp builtin_internal_label311 // range check ok
builtin_internal_label309: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label310: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label311: // range check ok
add r7, 1
add r12, r7
mov r12, [r12]
add r11, r12
push r11
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r9
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r9
mov r11, 6
push r11
mov r11, sp[27]
push r11
call rshift32
add sp, 2
pop r9
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
push r11
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r9
mov r11, 9
push r11
mov r11, sp[28]
push r11
call lshift32
add sp, 2
pop r9
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
push r11
call h2occ_core_xor
add sp, 2
pop r9
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
mov r12, sp[10]
add r11, r12
push r11
call h2occ_core_xor
add sp, 2
pop r9
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
add r9, r11
mov [r8], r9
lea r9, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r9
mov r8, 0x100000000
push r8
mov r8, sp[8]
push r8
call h2occ_core_mod
add sp, 2
pop r9
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov [r9], r8
lea r8, sp[2]
mov r9, sp[2]
mov r11, sp[3]
add r9, r11
mov [r8], r9
lea r9, sp[2]
push r1
push r3
push r5
push r6
push r2
push r4
push r9
mov r8, 0x100000000
push r8
mov r8, sp[10]
push r8
call h2occ_core_mod
add sp, 2
pop r9
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov [r9], r8
push r1
push r3
push r5
push r6
push r2
push r4
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, 10
push r8
mov r8, sp[13]
push r8
call rshift32
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
push r8
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, 2
push r8
mov r8, sp[14]
push r8
call lshift32
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
push r8
call h2occ_core_xor
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov r9, sp[0]
add r8, r9
mov sp[5], r8 // stack_var:tmp1
mov r8, sp[2]
mov r9, bp[4] // func_arg:key
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r9
mov r11, 4
push r11
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r9
mov r11, 11
push r11
mov r11, sp[20]
push r11
call rshift32
add sp, 2
pop r9
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
push r11
call h2occ_core_mod
add sp, 2
pop r9
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
mov r12, [r9]
jl r12, const_zero, builtin_internal_label313
jl r11, const_zero, builtin_internal_label312
jle r12, r11, builtin_internal_label312
jmp builtin_internal_label314 // range check ok
builtin_internal_label312: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label313: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label314: // range check ok
add r11, 1
add r9, r11
mov r9, [r9]
add r8, r9
mov sp[6], r8 // stack_var:tmp2
lea r8, sp[1]
mov r9, sp[1]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r9
mov r12, sp[14]
push r12
mov r12, sp[14]
push r12
call h2occ_core_xor
add sp, 2
pop r9
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
add r9, r12
mov [r8], r9
lea r9, sp[1]
push r1
push r3
push r5
push r6
push r2
push r4
push r9
mov r8, 0x100000000
push r8
mov r8, sp[9]
push r8
call h2occ_core_mod
add sp, 2
pop r9
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov [r9], r8
builtin_loop2_0_continue_pos:
lea r8, sp[4]
mov r9, sp[4]
mov r12, 1
add r9, r12
mov [r8], r9
jmp builtin_internal_label305
builtin_internal_label306:
builtin_loop2_0_break_pos:
mov r9, bp[3] // func_arg:v
mov r8, 0
mov r12, [r9]
jl r12, const_zero, builtin_internal_label316
jl r8, const_zero, builtin_internal_label315
jle r12, r8, builtin_internal_label315
jmp builtin_internal_label317 // range check ok
builtin_internal_label315: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label316: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label317: // range check ok
add r8, 1
add r9, r8
mov r12, sp[0]
mov [r9], r12
mov r12, bp[3] // func_arg:v
mov r9, 1
mov r8, [r12]
jl r8, const_zero, builtin_internal_label319
jl r9, const_zero, builtin_internal_label318
jle r8, r9, builtin_internal_label318
jmp builtin_internal_label320 // range check ok
builtin_internal_label318: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label319: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label320: // range check ok
add r9, 1
add r12, r9
mov r8, sp[1]
mov [r12], r8
encipher_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp[5], const_minus_one
mov sp[6], const_minus_one
mov sp, bp
pop bp
retn
aggregate_input:
push bp
mov bp, sp
sub sp, 2
mov r8, 0
mov sp[0], r8 // stack_var:i
builtin_internal_label321:
mov r8, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r12, bp[3] // func_arg:aggr
push r12
call len
add sp, 1
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
jl r8, r12, builtin_internal_label323
mov r8, 0
jmp builtin_internal_label324
builtin_internal_label323:
mov r8, 1
builtin_internal_label324:
je r8, const_zero, builtin_internal_label322
mov r8, bp[3] // func_arg:aggr
mov r12, sp[0]
mov r9, [r8]
jl r9, const_zero, builtin_internal_label326
jl r12, const_zero, builtin_internal_label325
jle r9, r12, builtin_internal_label325
jmp builtin_internal_label327 // range check ok
builtin_internal_label325: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label326: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label327: // range check ok
add r12, 1
add r8, r12
mov r9, 0
mov [r8], r9
builtin_loop3_0_continue_pos:
lea r9, sp[0]
mov r8, sp[0]
mov r12, 1
add r8, r12
mov [r9], r8
jmp builtin_internal_label321
builtin_internal_label322:
builtin_loop3_0_break_pos:
mov r8, 0
mov sp[1], r8 // stack_var:i
builtin_internal_label328:
mov r8, sp[1]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r9, bp[2] // func_arg:arr
push r9
call len
add sp, 1
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
jl r8, r9, builtin_internal_label330
mov r8, 0
jmp builtin_internal_label331
builtin_internal_label330:
mov r8, 1
builtin_internal_label331:
je r8, const_zero, builtin_internal_label329
mov r8, bp[3] // func_arg:aggr
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r9, 4
push r9
mov r9, sp[9]
push r9
call h2occ_core_div
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
mov r12, [r8]
jl r12, const_zero, builtin_internal_label333
jl r9, const_zero, builtin_internal_label332
jle r12, r9, builtin_internal_label332
jmp builtin_internal_label334 // range check ok
builtin_internal_label332: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label333: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label334: // range check ok
add r9, 1
add r8, r9
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r12, 8
push r12
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r12, 4
push r12
mov r12, sp[31]
push r12
call h2occ_core_mod
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
push r12
call h2occ_core_mult
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
push r12
mov r12, bp[2] // func_arg:arr
mov r9, sp[16]
mov r11, [r12]
jl r11, const_zero, builtin_internal_label336
jl r9, const_zero, builtin_internal_label335
jle r11, r9, builtin_internal_label335
jmp builtin_internal_label337 // range check ok
builtin_internal_label335: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label336: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label337: // range check ok
add r9, 1
add r12, r9
mov r12, [r12]
push r12
call lshift32
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
push r12
mov r12, bp[3] // func_arg:aggr
push r1
push r3
push r5
push r6
push r2
push r4
push r8
push r12
mov r11, 4
push r11
mov r11, sp[18]
push r11
call h2occ_core_div
add sp, 2
pop r12
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r11, r0
mov r9, [r12]
jl r9, const_zero, builtin_internal_label339
jl r11, const_zero, builtin_internal_label338
jle r9, r11, builtin_internal_label338
jmp builtin_internal_label340 // range check ok
builtin_internal_label338: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label339: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label340: // range check ok
add r11, 1
add r12, r11
mov r12, [r12]
push r12
call h2occ_core_or
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
mov [r8], r12
builtin_loop4_0_continue_pos:
lea r12, sp[1]
mov r8, sp[1]
mov r9, 1
add r8, r9
mov [r12], r8
jmp builtin_internal_label328
builtin_internal_label329:
builtin_loop4_0_break_pos:
aggregate_input_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp, bp
pop bp
retn
get_input:
push bp
mov bp, sp
sub sp, 2
mov r8, 0
mov sp[0], r8 // stack_var:i
builtin_internal_label341:
mov r8, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r12, bp[2] // func_arg:arr
push r12
call len
add sp, 1
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
jl r8, r12, builtin_internal_label343
mov r8, 0
jmp builtin_internal_label344
builtin_internal_label343:
mov r8, 1
builtin_internal_label344:
je r8, const_zero, builtin_internal_label342
push r1
push r3
push r5
push r6
push r2
push r4
call getchar
add sp, 0
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov sp[1], r8 // stack_var:c
mov r8, sp[1]
mov r12, 10
je r8, r12, builtin_internal_label345
mov r8, 1
jmp builtin_internal_label346
builtin_internal_label345:
mov r8, 0
builtin_internal_label346:
je r8, const_zero, builtin_internal_label347
mov r8, bp[2] // func_arg:arr
mov r12, sp[0]
mov r9, [r8]
jl r9, const_zero, builtin_internal_label350
jl r12, const_zero, builtin_internal_label349
jle r9, r12, builtin_internal_label349
jmp builtin_internal_label351 // range check ok
builtin_internal_label349: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label350: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label351: // range check ok
add r12, 1
add r8, r12
mov r9, sp[1]
mov [r8], r9
jmp builtin_internal_label348
builtin_internal_label347:
jmp builtin_loop5_0_break_pos
builtin_internal_label348:
builtin_loop5_0_continue_pos:
lea r9, sp[0]
mov r8, sp[0]
mov r12, 1
add r8, r12
mov [r9], r8
jmp builtin_internal_label341
builtin_internal_label342:
builtin_loop5_0_break_pos:
get_input_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp, bp
pop bp
retn
verify:
push bp
mov bp, sp
sub sp, 33
lea r9, sp[1]
mov sp[0], r9 // the memory stack_var:aggr points to
mov r8, 8
mov sp[1], r8 // the memory's size
mov r8, 0
mov sp[2], r8 // aggr[0]
mov r8, 0
mov sp[3], r8 // aggr[1]
mov r8, 0
mov sp[4], r8 // aggr[2]
mov r8, 0
mov sp[5], r8 // aggr[3]
mov r8, 0
mov sp[6], r8 // aggr[4]
mov r8, 0
mov sp[7], r8 // aggr[5]
mov r8, 0
mov sp[8], r8 // aggr[6]
mov r8, 0
mov sp[9], r8 // aggr[7]
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, sp[6]
push r8
mov r8, bp[2] // func_arg:arr
push r8
call aggregate_input
add sp, 2
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
lea r9, sp[11]
mov sp[10], r9 // the memory stack_var:key points to
mov r8, 4
mov sp[11], r8 // the memory's size
mov r8, 0x636f3268
mov sp[12], r8 // key[0]
mov r8, 0x636f3268
mov sp[13], r8 // key[1]
mov r8, 0x636f3268
mov sp[14], r8 // key[2]
mov r8, 0x636f3268
mov sp[15], r8 // key[3]
lea r9, sp[17]
mov sp[16], r9 // the memory stack_var:target points to
mov r8, 8
mov sp[17], r8 // the memory's size
mov r8, 1979671746
mov sp[18], r8 // target[0]
mov r8, 897489479
mov sp[19], r8 // target[1]
mov r8, 1099794343
mov sp[20], r8 // target[2]
mov r8, 1301154413
mov sp[21], r8 // target[3]
mov r8, 1769714755
mov sp[22], r8 // target[4]
mov r8, 960071495
mov sp[23], r8 // target[5]
mov r8, 1038852409
mov sp[24], r8 // target[6]
mov r8, 3276753339
mov sp[25], r8 // target[7]
mov r8, 0
mov sp[26], r8 // stack_var:i
builtin_internal_label352:
mov r8, sp[26]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r9, 2
push r9
mov r9, 8
push r9
call h2occ_core_div
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
jl r8, r9, builtin_internal_label354
mov r8, 0
jmp builtin_internal_label355
builtin_internal_label354:
mov r8, 1
builtin_internal_label355:
je r8, const_zero, builtin_internal_label353
lea r9, sp[28]
mov sp[27], r9 // the memory stack_var:v points to
mov r8, 2
mov sp[28], r8 // the memory's size
mov r8, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r9, 2
push r9
mov r9, sp[34]
push r9
call h2occ_core_mult
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
mov r12, [r8]
jl r12, const_zero, builtin_internal_label357
jl r9, const_zero, builtin_internal_label356
jle r12, r9, builtin_internal_label356
jmp builtin_internal_label358 // range check ok
builtin_internal_label356: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label357: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label358: // range check ok
add r9, 1
add r8, r9
mov r8, [r8]
mov sp[29], r8 // v[0]
mov r8, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r12, 2
push r12
mov r12, sp[34]
push r12
call h2occ_core_mult
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
mov r9, 1
add r12, r9
mov r9, [r8]
jl r9, const_zero, builtin_internal_label360
jl r12, const_zero, builtin_internal_label359
jle r9, r12, builtin_internal_label359
jmp builtin_internal_label361 // range check ok
builtin_internal_label359: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label360: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label361: // range check ok
add r12, 1
add r8, r12
mov r8, [r8]
mov sp[30], r8 // v[1]
push r1
push r3
push r5
push r6
push r2
push r4
mov r8, sp[16]
push r8
mov r8, sp[34]
push r8
mov r8, 8
push r8
call encipher
add sp, 3
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r8
mov r9, 2
push r9
mov r9, sp[34]
push r9
call h2occ_core_mult
add sp, 2
pop r8
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r9, r0
mov r12, [r8]
jl r12, const_zero, builtin_internal_label363
jl r9, const_zero, builtin_internal_label362
jle r12, r9, builtin_internal_label362
jmp builtin_internal_label364 // range check ok
builtin_internal_label362: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label363: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label364: // range check ok
add r9, 1
add r8, r9
mov r12, sp[27]
mov r9, 0
mov r11, [r12]
jl r11, const_zero, builtin_internal_label366
jl r9, const_zero, builtin_internal_label365
jle r11, r9, builtin_internal_label365
jmp builtin_internal_label367 // range check ok
builtin_internal_label365: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label366: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label367: // range check ok
add r9, 1
add r12, r9
mov r12, [r12]
mov [r8], r12
mov r12, sp[0]
push r1
push r3
push r5
push r6
push r2
push r4
push r12
mov r8, 2
push r8
mov r8, sp[34]
push r8
call h2occ_core_mult
add sp, 2
pop r12
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r8, r0
mov r11, 1
add r8, r11
mov r11, [r12]
jl r11, const_zero, builtin_internal_label369
jl r8, const_zero, builtin_internal_label368
jle r11, r8, builtin_internal_label368
jmp builtin_internal_label370 // range check ok
builtin_internal_label368: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label369: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label370: // range check ok
add r8, 1
add r12, r8
mov r11, sp[27]
mov r8, 1
mov r9, [r11]
jl r9, const_zero, builtin_internal_label372
jl r8, const_zero, builtin_internal_label371
jle r9, r8, builtin_internal_label371
jmp builtin_internal_label373 // range check ok
builtin_internal_label371: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label372: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label373: // range check ok
add r8, 1
add r11, r8
mov r11, [r11]
mov [r12], r11
builtin_loop6_0_continue_pos:
lea r11, sp[26]
mov r12, sp[26]
mov r9, 1
add r12, r9
mov [r11], r12
jmp builtin_internal_label352
builtin_internal_label353:
builtin_loop6_0_break_pos:
mov r12, 1
mov sp[31], r12 // stack_var:ok
mov r12, 0
mov sp[32], r12 // stack_var:i
builtin_internal_label374:
mov r12, sp[32]
mov r11, 8
jl r12, r11, builtin_internal_label376
mov r12, 0
jmp builtin_internal_label377
builtin_internal_label376:
mov r12, 1
builtin_internal_label377:
je r12, const_zero, builtin_internal_label375
mov r12, sp[0]
mov r11, sp[32]
mov r9, [r12]
jl r9, const_zero, builtin_internal_label379
jl r11, const_zero, builtin_internal_label378
jle r9, r11, builtin_internal_label378
jmp builtin_internal_label380 // range check ok
builtin_internal_label378: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label379: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label380: // range check ok
add r11, 1
add r12, r11
mov r12, [r12]
mov r9, sp[16]
mov r11, sp[32]
mov r8, [r9]
jl r8, const_zero, builtin_internal_label382
jl r11, const_zero, builtin_internal_label381
jle r8, r11, builtin_internal_label381
jmp builtin_internal_label383 // range check ok
builtin_internal_label381: // range check failure
mov r0, -2
push r0
call h2occ_core_runtime_error
builtin_internal_label382: // arr valid check failure
mov r0, -3
push r0
call h2occ_core_runtime_error
builtin_internal_label383: // range check ok
add r11, 1
add r9, r11
mov r9, [r9]
je r12, r9, builtin_internal_label384
mov r12, 1
jmp builtin_internal_label385
builtin_internal_label384:
mov r12, 0
builtin_internal_label385:
je r12, const_zero, builtin_internal_label387
lea r12, sp[31]
mov r9, 0
mov [r12], r9
jmp builtin_loop7_0_break_pos
builtin_internal_label387:
builtin_loop7_0_continue_pos:
lea r9, sp[32]
mov r12, sp[32]
mov r8, 1
add r12, r8
mov [r9], r12
jmp builtin_internal_label374
builtin_internal_label375:
builtin_loop7_0_break_pos:
mov r12, sp[31]
mov r0, r12
jmp verify_func_return
verify_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp[5], const_minus_one
mov sp[6], const_minus_one
mov sp[7], const_minus_one
mov sp[8], const_minus_one
mov sp[9], const_minus_one
mov sp[10], const_minus_one
mov sp[11], const_minus_one
mov sp[12], const_minus_one
mov sp[13], const_minus_one
mov sp[14], const_minus_one
mov sp[15], const_minus_one
mov sp[16], const_minus_one
mov sp[17], const_minus_one
mov sp[18], const_minus_one
mov sp[19], const_minus_one
mov sp[20], const_minus_one
mov sp[21], const_minus_one
mov sp[22], const_minus_one
mov sp[23], const_minus_one
mov sp[24], const_minus_one
mov sp[25], const_minus_one
mov sp[26], const_minus_one
mov sp[27], const_minus_one
mov sp[28], const_minus_one
mov sp[29], const_minus_one
mov sp[30], const_minus_one
mov sp[31], const_minus_one
mov sp[32], const_minus_one
mov sp, bp
pop bp
retn
main:
push bp
mov bp, sp
sub sp, 35
lea r9, sp[1]
mov sp[0], r9 // the memory stack_var:arr points to
mov r12, 32
mov sp[1], r12 // the memory's size
mov r12, 0
mov sp[2], r12 // arr[0]
mov r12, 0
mov sp[3], r12 // arr[1]
mov r12, 0
mov sp[4], r12 // arr[2]
mov r12, 0
mov sp[5], r12 // arr[3]
mov r12, 0
mov sp[6], r12 // arr[4]
mov r12, 0
mov sp[7], r12 // arr[5]
mov r12, 0
mov sp[8], r12 // arr[6]
mov r12, 0
mov sp[9], r12 // arr[7]
mov r12, 0
mov sp[10], r12 // arr[8]
mov r12, 0
mov sp[11], r12 // arr[9]
mov r12, 0
mov sp[12], r12 // arr[10]
mov r12, 0
mov sp[13], r12 // arr[11]
mov r12, 0
mov sp[14], r12 // arr[12]
mov r12, 0
mov sp[15], r12 // arr[13]
mov r12, 0
mov sp[16], r12 // arr[14]
mov r12, 0
mov sp[17], r12 // arr[15]
mov r12, 0
mov sp[18], r12 // arr[16]
mov r12, 0
mov sp[19], r12 // arr[17]
mov r12, 0
mov sp[20], r12 // arr[18]
mov r12, 0
mov sp[21], r12 // arr[19]
mov r12, 0
mov sp[22], r12 // arr[20]
mov r12, 0
mov sp[23], r12 // arr[21]
mov r12, 0
mov sp[24], r12 // arr[22]
mov r12, 0
mov sp[25], r12 // arr[23]
mov r12, 0
mov sp[26], r12 // arr[24]
mov r12, 0
mov sp[27], r12 // arr[25]
mov r12, 0
mov sp[28], r12 // arr[26]
mov r12, 0
mov sp[29], r12 // arr[27]
mov r12, 0
mov sp[30], r12 // arr[28]
mov r12, 0
mov sp[31], r12 // arr[29]
mov r12, 0
mov sp[32], r12 // arr[30]
mov r12, 0
mov sp[33], r12 // arr[31]
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 10
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 87
_out_ r12
mov r12, 101
_out_ r12
mov r12, 108
_out_ r12
mov r12, 99
_out_ r12
mov r12, 111
_out_ r12
mov r12, 109
_out_ r12
mov r12, 101
_out_ r12
mov r12, 32
_out_ r12
mov r12, 116
_out_ r12
mov r12, 111
_out_ r12
mov r12, 32
_out_ r12
mov r12, 78
_out_ r12
mov r12, 49
_out_ r12
mov r12, 67
_out_ r12
mov r12, 84
_out_ r12
mov r12, 70
_out_ r12
mov r12, 50
_out_ r12
mov r12, 48
_out_ r12
mov r12, 50
_out_ r12
mov r12, 51
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 10
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 62
_out_ r12
mov r12, 62
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 104
_out_ r12
mov r12, 50
_out_ r12
mov r12, 111
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 60
_out_ r12
mov r12, 60
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 10
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 97
_out_ r12
mov r12, 46
_out_ r12
mov r12, 107
_out_ r12
mov r12, 46
_out_ r12
mov r12, 97
_out_ r12
mov r12, 46
_out_ r12
mov r12, 32
_out_ r12
mov r12, 65
_out_ r12
mov r12, 110
_out_ r12
mov r12, 99
_out_ r12
mov r12, 105
_out_ r12
mov r12, 101
_out_ r12
mov r12, 110
_out_ r12
mov r12, 116
_out_ r12
mov r12, 32
_out_ r12
mov r12, 71
_out_ r12
mov r12, 97
_out_ r12
mov r12, 109
_out_ r12
mov r12, 101
_out_ r12
mov r12, 32
_out_ r12
mov r12, 86
_out_ r12
mov r12, 51
_out_ r12
mov r12, 32
_out_ r12
mov r12, 32
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 10
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 42
_out_ r12
mov r12, 10
_out_ r12
mov r12, 73
_out_ r12
mov r12, 110
_out_ r12
mov r12, 112
_out_ r12
mov r12, 117
_out_ r12
mov r12, 116
_out_ r12
mov r12, 32
_out_ r12
mov r12, 121
_out_ r12
mov r12, 111
_out_ r12
mov r12, 117
_out_ r12
mov r12, 114
_out_ r12
mov r12, 32
_out_ r12
mov r12, 102
_out_ r12
mov r12, 108
_out_ r12
mov r12, 97
_out_ r12
mov r12, 103
_out_ r12
mov r12, 58
_out_ r12
mov r12, 32
_out_ r12
mov r12, 10
_out_ r12
push r1
push r3
push r5
push r6
push r2
push r4
mov r12, sp[6]
push r12
call get_input
add sp, 1
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, 86
_out_ r12
mov r12, 101
_out_ r12
mov r12, 114
_out_ r12
mov r12, 105
_out_ r12
mov r12, 102
_out_ r12
mov r12, 121
_out_ r12
mov r12, 105
_out_ r12
mov r12, 110
_out_ r12
mov r12, 103
_out_ r12
mov r12, 46
_out_ r12
mov r12, 46
_out_ r12
mov r12, 46
_out_ r12
mov r12, 10
_out_ r12
push r1
push r3
push r5
push r6
push r2
push r4
mov r12, sp[6]
push r12
call verify
add sp, 1
pop r4
pop r2
pop r6
pop r5
pop r3
pop r1
mov r12, r0
mov sp[34], r12 // stack_var:ret
mov r12, sp[34]
je r12, const_zero, builtin_internal_label388
mov r12, 79
_out_ r12
mov r12, 75
_out_ r12
mov r12, 33
_out_ r12
mov r12, 10
_out_ r12
jmp builtin_internal_label389
builtin_internal_label388:
mov r12, 84
_out_ r12
mov r12, 114
_out_ r12
mov r12, 121
_out_ r12
mov r12, 32
_out_ r12
mov r12, 97
_out_ r12
mov r12, 103
_out_ r12
mov r12, 97
_out_ r12
mov r12, 105
_out_ r12
mov r12, 110
_out_ r12
mov r12, 46
_out_ r12
mov r12, 10
_out_ r12
builtin_internal_label389:
mov r12, 0
mov r0, r12
jmp main_func_return
main_func_return:
// stack invalidation
mov sp[0], const_minus_one
mov sp[1], const_minus_one
mov sp[2], const_minus_one
mov sp[3], const_minus_one
mov sp[4], const_minus_one
mov sp[5], const_minus_one
mov sp[6], const_minus_one
mov sp[7], const_minus_one
mov sp[8], const_minus_one
mov sp[9], const_minus_one
mov sp[10], const_minus_one
mov sp[11], const_minus_one
mov sp[12], const_minus_one
mov sp[13], const_minus_one
mov sp[14], const_minus_one
mov sp[15], const_minus_one
mov sp[16], const_minus_one
mov sp[17], const_minus_one
mov sp[18], const_minus_one
mov sp[19], const_minus_one
mov sp[20], const_minus_one
mov sp[21], const_minus_one
mov sp[22], const_minus_one
mov sp[23], const_minus_one
mov sp[24], const_minus_one
mov sp[25], const_minus_one
mov sp[26], const_minus_one
mov sp[27], const_minus_one
mov sp[28], const_minus_one
mov sp[29], const_minus_one
mov sp[30], const_minus_one
mov sp[31], const_minus_one
mov sp[32], const_minus_one
mov sp[33], const_minus_one
mov sp[34], const_minus_one
mov sp, bp
pop bp
retn
globals:
ds stack 100000, 0

global_init:

call main
program_end:
