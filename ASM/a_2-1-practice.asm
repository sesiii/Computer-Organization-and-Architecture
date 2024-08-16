.data
input_prompt:
    .asciiz "Enter the number to be divided by 255: "
output_quotient:
    .asciiz "\nQuotient: "
output_remainder:
    .asciiz "\nRemainder: "

.text
.globl main
main:
    # Print input prompt
    la $a0, input_prompt
    li $v0, 4
    syscall

    # Read integer input
    li $v0, 5
    syscall
    move $t0, $v0  # $t0 contains the number to be divided

    # Initialize constants
    li $t3, 256    # Corrected: Divisor (256)
    li $t1, 0      # Quotient
    li $t2, 0      # Remainder

    # Compute quotient and remainder
    li $t4, 1      # Initial bit position
    li $t5, 8      # Number of bits for 256 (2^8)

divide_loop:
    blez $t0, end_division  # If the number is zero or less, end

    # Calculate the divisor shifted by the current bit
    sll $t6, $t4, $t5       # $t6 = 2^8 (i.e., 256)
    bge $t0, $t6, subtract   # If the number >= shifted divisor, subtract

    # Shift divisor and quotient
    srl $t6, $t6, 1         # Shift right divisor for the next bit
    srl $t0, $t0, 1         # Shift number for the next bit
    srl $t1, $t1, 1         # Shift quotient for the next bit
    j divide_loop           # Continue loop

subtract:
    subu $t0, $t0, $t6      # Corrected: Subtract divisor from number
    addi $t1, $t1, 1        # Increment quotient
    j divide_loop           # Continue loop

end_division:
    # Print the quotient
    la $a0, output_quotient
    li $v0, 4
    syscall

    move $a0, $t1
    li $v0, 1
    syscall

    # Print the remainder
    la $a0, output_remainder
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    # Exit the program
    li $v0, 10
    syscall
