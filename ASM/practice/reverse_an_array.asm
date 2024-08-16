.data
array: .space 20000    
prompt1: .asciiz "Enter an integer n: "
prompt2: .asciiz "Enter array elements (n integers): "
newline: .asciiz "\n"
space: .asciiz " "
sum: .word 0

.text
.globl main
main:
    
    # Print prompt1
    li $v0, 4           
    la $a0, prompt1     
    syscall             

    # Read integer n
    li $v0, 5           
    syscall             
    move $s0, $v0       # Store n in $s0

    # Print prompt2
    li $v0, 4           
    la $a0, prompt2     
    syscall             

    # Initialize loop variables
    li $t2, 0           
    la $t3, array       

input_loop:
    beq $t2, $s0, print_array  # Exit loop if counter equals n
    
    # Read an integer
    li $v0, 5           
    syscall             
    move $t1, $v0       

    # Store the integer in the array
    sw $t1, ($t3)       
    addi $t3, $t3, 4    # Move to next array element
    addi $t2, $t2, 1    # Increment counter

    j input_loop        # Repeat the loop

print_array:
    li $t2, 0
    la $t3, array

print_loop:
    beq $t2, $s0, end  # Exit loop if counter equals n

    # Load the integer from the array
    lw $t1, ($t3)

    # Print the integer
    li $v0, 1
    move $a0, $t1
    syscall

    # Print a space
    li $v0, 4
    la $a0, space
    syscall

    addi $t3, $t3, 4    # Move to next array element
    addi $t2, $t2, 1    # Increment counter

    j print_loop        # Repeat the loop
end:
    # Exit program
    li $v0, 10        
    syscall     
