.data
str: .space 200000
len: .word 3
prompt1: .asciiz "Enter a string: "
newline: .asciiz "\n\n"

.text
.globl main

main:
      li $v0, 4
      la $a0, prompt1
      syscall

      li $v0,8
      la $a0, str
      li $a1, 100
      syscall

      li $v0,4
      la $a0, str
      syscall

      li $v0, 4
      la $a0, newline
      syscall
      
      la $t0, str          # Address of the string
      li $t1, 0            # Length counter

calculate_length:
     lb $t2, 0($t0)       # Load byte from the string
     beqz $t2, print_length  # If byte is zero (end of string), go to print_string
     addi $t1, $t1, 1     # Increment length counter
     addi $t0, $t0, 1     # Move to the next byte
     j calculate_length   # Repeat

print_length:
      li $v0,1
      move $a0,$t1
      syscall

      
      li $v0, 10          
      syscall             
