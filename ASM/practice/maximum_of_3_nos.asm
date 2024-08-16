.data
prompt1: .asciiz "Enter number 1: "
prompt2: .asciiz "Enter number 2: "
prompt3: .asciiz "Enter number 3: "
space: .asciiz " "
newline: .asciiz "\n\n"

.text
.globl main

main:
    # Print prompt1 and read first integer
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  # Store the first integer in $t0

    # Print prompt2 and read second integer
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0  # Store the second integer in $t1

    # Print prompt3 and read third integer
    li $v0, 4
    la $a0, prompt3
    syscall

    li $v0, 5
    syscall
    move $t2, $v0  # Store the third integer in $t2

    # Print the first integer
    li $v0, 1
    move $a0, $t0
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    # Print the second integer
    li $v0, 1
    move $a0, $t1
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    # Print the third integer
    li $v0, 1
    move $a0, $t2
    syscall

    # Print newline for separation
    li $v0, 4
    la $a0, newline
    syscall

    # Initialize $t3 with $t0 (considering it as the initial max)
    move $t3, $t0

    # Compare $t3 (max) with $t1
    bge $t1, $t3, set_t1_max

    # If $t1 is not greater than $t3, keep $t3 as max
    j compare_t2

set_t1_max:
    move $t3, $t1  # $t1 is the new max

compare_t2:
    # Compare $t3 (max) with $t2
    bge $t2, $t3, print_max

    # If $t2 is not greater than $t3, keep $t3 as max
    move $t3, $t2  # $t2 is the new max

print_max:
    # Print the maximum number
    li $v0, 1
    move $a0, $t3
    syscall

    # Exit program
    li $v0, 10
    syscall
