.data
prompt1: .asciiz "Enter the size of the array: "
prompt2: .asciiz "Enter element "
prompt3: .asciiz ": "
prompt4: .asciiz "Reversed array: "
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
    beq $t0, $s0, reverse_array

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

reverse_array:
    la $t0, array       # $t0 = start of array
    la $t1, array       
    sll $t2, $s0, 2     # $t2 = size * 4
    add $t1, $t1, $t2   
    addi $t1, $t1, -4   # $t1 = end of array

    # Reverse loop
reverse_loop:
    bge $t0, $t1, print_array

    # Swap elements
    lw $t2, 0($t0)      # $t2 = array[start]
    lw $t3, 0($t1)      # $t3 = array[end]
    
    sw $t3, 0($t0)      # array[start] = $t3
    sw $t2, 0($t1)      # array[end] = $t2

    # Move pointers
    addi $t0, $t0, 4
    addi $t1, $t1, -4

    j reverse_loop

print_array:
    # Print "Reversed array: "
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