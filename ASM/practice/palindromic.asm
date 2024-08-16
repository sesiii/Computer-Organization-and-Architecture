.data
prompt:     .asciiz "Enter a string: "
is_pal:     .asciiz "The string is a palindrome."
not_pal:    .asciiz "The string is not a palindrome."
newline:    .asciiz "\n"
buffer:     .space 100    # Buffer to store the input string

.text
.globl main

main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read string
    li $v0, 8
    la $a0, buffer
    li $a1, 100
    syscall

    # Find string length (excluding newline)
    la $t0, buffer      # $t0 = string address
    li $t1, 0           # $t1 = length counter

length_loop:
    lb $t2, ($t0)
    beq $t2, 10, end_length  # Check for newline
    beq $t2, 0, end_length   # Check for null terminator
    addi $t1, $t1, 1
    addi $t0, $t0, 1
    j length_loop

end_length:
    # Set up for palindrome check
    la $t0, buffer      # $t0 = start of string
    add $t1, $t0, $t1
    addi $t1, $t1, -1   # $t1 = end of string (before newline)

check_palindrome:
    bge $t0, $t1, is_palindrome

    lb $t2, ($t0)
    lb $t3, ($t1)

    # Convert to lowercase if uppercase
    blt $t2, 'A', skip_lower1
    bgt $t2, 'Z', skip_lower1
    addi $t2, $t2, 32
skip_lower1:
    blt $t3, 'A', skip_lower2
    bgt $t3, 'Z', skip_lower2
    addi $t3, $t3, 32
skip_lower2:

    bne $t2, $t3, not_palindrome

    addi $t0, $t0, 1
    addi $t1, $t1, -1
    j check_palindrome

is_palindrome:
    # Print result
    li $v0, 4
    la $a0, is_pal
    syscall
    j exit

not_palindrome:
    # Print result
    li $v0, 4
    la $a0, not_pal
    syscall

exit:
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall