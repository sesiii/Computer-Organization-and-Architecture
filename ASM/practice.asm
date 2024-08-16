.data
integer: .word 0
prompt1: .asciiz "Enter an integer 1: "
prompt2: .asciiz "Enter an integer 2: "
prompt3: .asciiz "Addition: "
newline: .asciiz "\n"
prompt4: .asciiz "Subtraction: "
prompt5: .asciiz "Multiplication: "
prompt6: .asciiz "Division: "

.text
.globl main
main:
    la $a0, prompt1
    li $v0, 4
    syscall

    li $v0,5
    syscall
    move $t0,$v0

    la $a0, prompt2
    li $v0, 4
    syscall
    
    li $v0,5
    syscall
    move $t1,$v0

    #Addition
    add $t2,$t0,$t1

    la $a0, prompt3 #additon prompt
    li $v0,4    #print string syscall
    syscall     #print string syscall

    li $v0,1                 #print integer syscall
    move $a0,$t2      #print integer syscall
    syscall      #print integer syscall


    # Exit program
    li $v0, 10           # Exit syscall
    syscall