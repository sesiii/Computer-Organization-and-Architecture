.data
prompt1: .asciiz "Enter the size of the array: "
prompt2: .asciiz "Enter element "
prompt3: .asciiz ": "
prompt4: .asciiz "Sorted array: "
space:   .asciiz " "
newline: .asciiz "\n"
array:   .align 2
         .space 400    # Space for up to 100 integers (400 bytes)

.text
.globl main

main:
    # Ask for array size
    li $v0, 4
    la $a0, prompt1
    syscall

    # Read array size
    li $v0, 5
    syscall
    move $s0, $v0       # $s0 = array size

    # Initialize array input loop
    li $t0, 0           # $t0 = counter
    la $t1, array       # $t1 = array address

input_loop:
    beq $t0, $s0, sort_array

    # Print prompt
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, prompt3
    syscall

    # Read integer
    li $v0, 5
    syscall

    # Store in array
    sw $v0, 0($t1)

    # Increment counter and array address
    addi $t0, $t0, 1
    addi $t1, $t1, 4

    j input_loop

sort_array:
    li $t0, 0           # $t0 = i (outer loop counter)

outer_loop:
    addi $t0, $t0, 1
    beq $t0, $s0, print_array

    li $t1, 0           # $t1 = j (inner loop counter)

inner_loop:
    sub $t2, $s0, $t0
    beq $t1, $t2, outer_loop

    la $t3, array
    sll $t4, $t1, 2
    add $t3, $t3, $t4   # address of array[j]

    lw $t5, 0($t3)      # $t5 = array[j]
    lw $t6, 4($t3)      # $t6 = array[j+1]

    ble $t5, $t6, no_swap

    # Swap elements
    sw $t6, 0($t3)
    sw $t5, 4($t3)

no_swap:
    addi $t1, $t1, 1
    j inner_loop

print_array:
    # Print "Sorted array: "
    li $v0, 4
    la $a0, prompt4
    syscall

    li $t0, 0           # Counter
    la $t1, array       # Array address

print_loop:
    beq $t0, $s0, exit

    # Print number
    li $v0, 1
    lw $a0, 0($t1)
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 1
    addi $t1, $t1, 4
    j print_loop

exit:
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall