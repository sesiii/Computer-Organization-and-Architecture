.data
input: .word 20           # Input number
newline: .asciiz "\n"     # Newline character for output

.text
.globl main

main:
    #load the input
    li $v0,5
    syscall
    move $t0, $v0

    # Check for prime factors starting from 2
    li $t1,2  

find_factors:
    # If $t0 is 1, we are done
    beq $t0, $zero, done
    # Check if $t0 is divisible by $t1
    rem $t2, $t0, $t1
    # If not divisible, check next factor
    bnez $t2, next_factor

    # Print the factor $t1
    move $a0, $t1
    li $v0, 1
    syscall

    # Print a space
    li $a0,32
    # Print character syscall
    li $v0,11
    syscall

    div $t0,$t0,$t1
    j find_factors

next_factor:
    # Increment the factor
    addi $t1, $t1, 1
    # Skip even numbers after checking for 2
    beq $t1, 3, find_factors
    # Check if the number is even
    rem $t2, $t1, 2
    # If even, skip
    beqz $t2, next_factor

    j find_factors

skip_even:
    # Increment the factor
    addi $t1, $t1, 1
    j find_factors
    
done:
    la $a0,newline
    li $v0,4
    syscall

    # Exit program
    li $v0, 10           # Exit syscall
    syscall