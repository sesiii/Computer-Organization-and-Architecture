.data
input: .word 20
newline: .asciiz "\n"

.text
.globl main

main:
    # Load the input number
    li $v0, 5
    syscall
    move $t0, $v0        # $t0 contains the number to factorize

    # Check for prime factors starting from 2
    li $t1, 2            # $t1 is the current factor to test

    # Loop to find prime factors
find_factors:
    # If $t0 is 1, we are done
    beq $t0, $zero, done

    # Check if $t0 is divisible by $t1
    rem $t2, $t0, $t1    # $t2 = $t0 % $t1
    bnez $t2, next_factor

    # Print the factor $t1
    move $a0, $t1
    li $v0, 1            # Print integer syscall
    syscall

    # Print a space
    li $a0, 32           # ASCII for space
    li $v0, 11           # Print character syscall
    syscall

    # Divide $t0 by $t1
    div $t0, $t0, $t1

    # Repeat with the same factor
    j find_factors

next_factor:
    # Increment the factor
    addi $t1, $t1, 1
    
    # Skip even numbers after checking for 2
    beq $t1, 3, find_factors
    rem $t2, $t1, 2
    beqz $t2, next_factor

    j find_factors

done:
    # Print newline
    la $a0, newline
    li $v0, 4            # Print string syscall
    syscall

    # Exit program
    li $v0, 10           # Exit syscall
    syscall
