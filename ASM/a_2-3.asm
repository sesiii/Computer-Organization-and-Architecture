# Dadi Sasank Kumar-22CS10020
# Trilochan-22CS10048

.data
    in1: .asciiz "Enter the size of array: "
    N: .word 0
    array: .word 0
    dynamic_arr: .word 0
    ans: .word 0
    integer: .word 0
    message: .asciiz "Error encountered "
    done: .asciiz "\n\n Length of LCS: "

.text
.globl main
main:
    li $v0, 4
    la $a0, in1
    syscall

    li $v0, 5
    syscall
    sw $v0, N

    lw $t0, N
    blez $t0, escape

    li $v0, 9
    sll $a0, $t0, 2
    syscall
    sw $v0, array

    li $v0, 9
    syscall
    sw $v0, dynamic_arr

    li $t1, 0
    lw $t3, array
    lw $t2, dynamic_arr
    li $t8, -1

arr_input:
    beq $t1, $t0, process
    li $v0, 5
    syscall
    sw $v0, 0($t3)
    addi $t3, $t3, 4
    sw $t8, 0($t2)
    addi $t2, $t2, 4
    addi $t1, $t1, 1
    j arr_input

process:
    lw $t0, N
    addi $t1, $t0, -1
    lw $t2, array
    lw $t3, dynamic_arr
    li $t5, 1
    li $t8, -1
    sll $t4, $t1, 2
    add $t4, $t3, $t4
    sw $t5, 0($t4)
    addi $t1, $t1, -1

process_loop:
    bltz $t1, fmax
    sll $t4, $t1, 2
    add $t4, $t3, $t4
    lw $t4, 0($t4)
    bne $t4, $t8, iter

    sll $t4, $t1, 2
    add $t4, $t2, $t4
    lw $t5, 0($t4)
    lw $t6, 4($t4)
    bge $t5, $t6, set_one

    sll $t4, $t1, 2
    add $t4, $t3, $t4
    lw $t5, 4($t4)
    addi $t5, $t5, 1
    sw $t5, 0($t4)
    j iter

set_one:
    sll $t7, $t1, 2
    add $t7, $t3, $t7
    li $t6, 1
    sw $t6, 0($t7)

iter:
    addi $t1, $t1, -1
    j process_loop

fmax:
    li $t1, 0
    lw $t2, dynamic_arr
    li $t9, 0

find_max_loop:
    beq $t1, $t0, print_dynamic_arr
    sll $t3, $t1, 2
    add $t3, $t2, $t3
    lw $t3, 0($t3)
    bge $t3, $t9, max
    j skip_update

max:
    move $t9, $t3
    move $t8,$t1

skip_update:
    addi $t1, $t1, 1
    j find_max_loop

print_dynamic_arr:
    # lw $t1,integer
    # lw $t8,ans
    add $t7,$t8,$t9
    lw $t2, array
    move $t1,$t8
print_dynamic_arr_loop:
    beq $t1, $t7, exit
    sll $t3, $t1, 2
    add $t3, $t2, $t3
    lw $a0, 0($t3)
    li $v0, 1
    syscall
    li $v0, 11
    li $a0, 32
    syscall
    addi $t1, $t1, 1
    j print_dynamic_arr_loop

exit:
    li $v0, 4
    la $a0, done
    syscall

    li $v0, 1
    move $a0, $t9
    syscall

    li $v0, 10
    syscall

escape:
    li $v0, 4
    la $a0, erm
    syscall

    li $v0, 10
    syscall
