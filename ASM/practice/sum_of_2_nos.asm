.data
num1: .word 20
num2: .word 20
prompt1: .asciiz "Enter number 1: "
prompt2: .asciiz "Enter number 2: "

prompt3: .asciiz "Sum of num1 and num2: "
newline: .asciiz "\n\n"


.text
.globl main
main:

      li $v0,4
      la $a0,prompt1
      syscall

      li $v0,5
      syscall
      sw $v0,num1

      li $v0,4
      la $a0,prompt2
      syscall

      li $v0,5
      syscall
      sw $v0,num2

      li $v0,4
      la $a0,newline
      syscall

sum_of_numbers:

      li $v0,4
      la $a0,prompt3
      syscall

      lw $t0,num1
      lw $t1,num2
      add $t2,$t0,$t1
      move $a0,$t2
      li $v0,1
      syscall

      li $v0,4
      la $a0,newline
      syscall

      li $v0, 10
      syscall



