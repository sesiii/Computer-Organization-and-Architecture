.data
prompt_size: .asciiz "Enter the size of the array: "
prompt_elem: .asciiz "Enter element: "
output_lis: .asciiz "The longest increasing subsequence is: "
output_length: .asciiz " and its length is: "
error_msg: .asciiz "Error encountered in code."

.text
.globl main
main:
    # Prompt for the size of the array
    li $v0, 4
    la $a0, prompt_size
    syscall

    # Read the size of the array
    li $v0, 5
    syscall
    move $t0, $v0  # Store the size of the array in $t0

    blez $t0, error  # If size is zero or negative, jump to error

    # Allocate memory for the array and dp arrays
    li $v0, 9
    sll $a0, $t0, 2  # Size in bytes (4 bytes per word)
    syscall
    move $t1, $v0  # Base address of the array

    li $v0, 9
    syscall
    move $t2, $v0  # Base address of the dp array

    # Initialize the array and dp array
    li $t3, 0  # Index
    li $t4, -1 # Initial value for dp array
input_loop:
    beq $t3, $t0, process  # If all elements are read, jump to process

    # Prompt for each element
    li $v0, 4
    la $a0, prompt_elem
    syscall

    # Read the element
    li $v0, 5
    syscall
    sll $t5, $t3, 2
    add $t6, $t1, $t5
    sw $v0, 0($t6)  # Store the element in the array

    add $t6, $t2, $t5
    sw $t4, 0($t6)  # Initialize dp array with -1

    addi $t3, $t3, 1
    j input_loop

process:
    # Process the array to find the longest increasing subsequence (LIS)
    move $t3, $t0  # Size of the array
    addi $t3, $t3, -1
    li $t4, 1
    sll $t5, $t3, 2
    add $t6, $t2, $t5
    sw $t4, 0($t6)  # Initialize dp[t3] to 1

    addi $t3, $t3, -1
process_loop:
    bltz $t3, find_max  # If t3 < 0, jump to find_max

    sll $t5, $t3, 2
    add $t6, $t1, $t5
    lw $t7, 0($t6)  # arr[t3]

    add $t8, $t3, 1
inner_loop:
    beq $t8, $t0, next_outer  # If t8 == size, go to next_outer

    sll $t9, $t8, 2
    add $t10, $t1, $t9
    lw $t11, 0($t10)  # arr[t8]

    ble $t7, $t11, skip_update  # If arr[t3] <= arr[t8], skip

    add $t12, $t2, $t9
    lw $t13, 0($t12)  # dp[t8]
    addi $t13, $t13, 1

    add $t14, $t2, $t5
    lw $t15, 0($t14)  # dp[t3]

    ble $t15, $t13, skip_update  # If dp[t3] >= dp[t8] + 1, skip

    sw $t13, 0($t14)  # Update dp[t3]

skip_update:
    addi $t8, $t8, 1
    j inner_loop

next_outer:
    addi $t3, $t3, -1
    j process_loop

find_max:
    # Find the maximum length of LIS
    li $t3, 0
    li $t9, 0  # Maximum length
    move $t8, $t0

find_max_loop:
    beq $t3, $t0, print_lis  # If t3 == size, jump to print_lis

    sll $t5, $t3, 2
    add $t6, $t2, $t5
    lw $t7, 0($t6)  # dp[t3]

    bge $t7, $t9, update_max  # If dp[t3] >= max_length, update max

skip_update_max:
    addi $t3, $t3, 1
    j find_max_loop

update_max:
    move $t9, $t7  # Update max_length
    move $t8, $t3  # Update index of max_length
    j skip_update_max

print_lis:
    # Print the LIS
    li $v0, 4
    la $a0, output_lis
    syscall

    move $t6, $t8  # Start from the index of max_length
    li $t3, 0
    lw $t1, arr

print_lis_loop:
    beq $t3, $t9, print_length  # If t3 == max_length, jump to print_length

    sll $t5, $t6, 2
    add $t7, $t1, $t5
    lw $a0, 0($t7)  # Load arr[t6]

    li $v0, 1
    syscall  # Print the element

    li $v0, 11
    li $a0, 32  # Print space
    syscall

    addi $t3, $t3, 1
    j print_lis_loop

print_length:
    # Print the length of LIS
    li $v0, 4
    la $a0, output_length
    syscall

    move $a0, $t9
    li $v0, 1
    syscall

    li $v0, 10
    syscall

error:
    li $v0, 4
    la $a0, error_msg
    syscall

    li $v0, 10
    syscall
