# Dadi Sasank Kumar-22CS10020
# Trilochan-22CS10048

.data
array: .space 20000    
prompt1: .asciiz "Enter an integer n: "
prompt2: .asciiz "Enter array elements (n integers): "
newline: .asciiz "\n"
space: .asciiz " "
message: .asciiz "Array elements: "
sorted_message: .asciiz "Sorted array elements: "
finder_start: .asciiz "Enter k to find the k-th smallest and largest elements: "
kth_begin_message: .asciiz "k-th smallest element: "
kth_end_message: .asciiz "k-th largest element: "

.text
.globl main
main:
    
    li $v0, 4           
    la $a0, prompt1     
    syscall             

    li $v0, 5           
    syscall             
    move $s0, $v0      

    li $v0, 4           
    la $a0, prompt2     
    syscall             

    li $t2, 0           
    la $t3, array       

input_loop:
    
    li $v0, 5           
    syscall             
    move $t1, $v0       

    sw $t1, ($t3)       
    addi $t3, $t3, 4    # Move to next array element
    addi $t2, $t2, 1    # Increment counter

    blt $t2, $s0, input_loop   

    li $v0, 4
    la $a0, message
    syscall

    # Reset array contents (for printing)
    li $t2, 0           
    la $t3, array       

print_array:
    beq $t2, $s0, sort_array 

    lw $t1, ($t3)       
    li $v0, 1           
    move $a0, $t1       
    syscall             

    li $v0, 4
    la $a0, space
    syscall

    addi $t3, $t3, 4    
    addi $t2, $t2, 1    

    j print_array       

sort_array:
    # Sort the array using bubble sort
    li $t5, 1           

bubble_sort_outer:
    beqz $t5, end_sort  

    li $t5, 0           
    li $t2, 0           
    la $t3, array       

bubble_sort_inner:
    sub $t6, $s0, $t2   
    blez $t6, bubble_sort_outer_end 

    lw $t7, ($t3)       
    lw $t8, 4($t3)      

    ble $t7, $t8, no_swap 

    # Swap the elements
    sw $t8, ($t3)       
    sw $t7, 4($t3)      
    li $t5, 1           

no_swap:
    addi $t3, $t3, 4    
    addi $t2, $t2, 1    

    j bubble_sort_inner 

bubble_sort_outer_end:
    j bubble_sort_outer 

end_sort:
    # Print newline
    li $v0, 4           
    la $a0, newline     
    syscall             

    li $v0, 4
    la $a0, sorted_message
    syscall

    # Print sorted array
    li $t2, 0           
    la $t3, array       

print_sorted_array:
    beq $t2, $s0, find_kth_element 

    lw $t1, 4($t3)       
    li $v0, 1           
    move $a0, $t1       
    syscall             

    li $v0, 4
    la $a0, space
    syscall

    addi $t3, $t3, 4    
    addi $t2, $t2, 1    

    j print_sorted_array # repeat loop

find_kth_element:
    
    li $v0, 4           
    la $a0, newline     
    syscall             

    li $v0, 4
    la $a0, finder_start
    syscall

    li $v0, 5
    syscall
    move $s1, $v0       # store k in $s1

    li $v0, 4
    la $a0, kth_begin_message
    syscall

    
    sll $t1, $s1, 2     # k * 4
    lw $t1, array($t1)  
    li $v0, 1           
    move $a0, $t1       
    syscall             

    li $v0, 4           
    la $a0, newline     
    syscall             

    li $v0, 4
    la $a0, kth_end_message
    syscall

    # Find k-th element from the end
    sub $t1, $s0, $s1   # n - k
    add $t1, $t1, 1    # (n - k +1) 
    sll $t1, $t1, 2     # (n - k + 1) * 4
    lw $t1, array($t1)  
    li $v0, 1           
    move $a0, $t1       
    syscall             

end_program:
    # End of program
    li $v0, 10          
    syscall             
