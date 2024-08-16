# data
# array1: .space 12 # declare 12 bytes of storage to hold array of 3 integers
# .text
# __start: la $t0, array1 # load base address of array into register $t0
# li $t1, 5 # $t1 = 5 ("load immediate")
# sw $t1, ($t0) # first array element set to 5; indirect addressing
# li $t1, 13 # $t1 = 13
# sw $t1, 4($t0) # second array element set to 13
# li $t1, -7 # $t1 = -7
# sw $t1, 8($t0) # third array element set to -7
# done


.data
array: .space 20000
prompt1: .asciiz "Enter an integer n : "
prompt2: .asciiz "Enter an integer k : "
prompt3: .asciiz "Enter array elements : "
prompt4: .asciiz "Array:  "
newline: .asciiz "\n"
integer: .word 0

.text
.globl main

main:
    la $a0, prompt1
    li $v0, 4
    syscall
    
    li $v0,5
    syscall
    # move $t4,$v0 #$t4=n
    move $s0,$v0

    li $t2,0
    # addi $t2,$t2,0 #index
    la $s1, array
    move $t3,$s1
    # beq $t2,$t2,readint

readint:
    
    la $a0, prompt3
    li $v0, 4
    syscall

    li $v0,5
    syscall
    move $t1,$v0 #input

    sw $t1, ($t3)

    addi $t3,$t3,4 #adress+=4
    addi $t2,$t2,1 #index+=1
    # sw $t1, ($t0)
    # sw $t1, ($t3)

    blt $t2,$s0, readint
    move $t3,$s1
    # jal printarray

# label1: 
    # beq $t2,$t2,printarray

    # # End of program

    # li $v0, 10        # syscall code 10 for exit
    # syscall

printarray:
    la $a0, prompt3
    li $v0, 4
    syscall

    li $v0,1
    syscall
    move $t1,$v0 #input

    sw $t1, ($t3)

    addi $t3,$t3,4 #adress+=4
    addi $t2,$t2,1 #index+=1
    # sw $t1, ($t0)
    sw $t1, ($t3)

    blt $t2,$t4, printarray
    j end_program

end_program:
    li $v0, 10        # Load appropriate system call code into register $v0 (exit)
    syscall    
    
    
