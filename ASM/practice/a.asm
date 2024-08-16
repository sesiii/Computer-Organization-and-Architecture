.data
num: .word 20
newline: .asciiz "\n"

prompt1: .asciiz "Enter a number: "
square: .word 20

.text
.globl main
main:
      li $v0,4
      la $a0,prompt1
      syscall

      li $v0,5
      syscall

      sw $v0,num
      lw $a0,num

      li $v0,1
      syscall

      li $v0,4
      la $a0,newline
      syscall

square_of_num:
      lw $t0,num
      mul $t1,$t0,$t0
      sw $t1,square

      lw $a0,square
      li $v0,1
      syscall

      li $v0,4
      la $a0,newline
      syscall

      li $v0, 10           # Exit syscall
      syscall


      
