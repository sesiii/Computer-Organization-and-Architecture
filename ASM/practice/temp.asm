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
      li $v0,4
      la $a0,prompt1
      syscall

      li $v0,5
      syscall
      move $s0,$v0

      li $v0,4
      la $a0, prompt2
      syscall

      li $t0,0
      la $t1, array

input_loop:
      beq $t0,$s0,print_loop
      li $v0,5
      syscall

      move $t2,$v0

      sw $t2,($t1)
      addi $t1,$t1,4
      addi $t0,$t0,1

      j input_loop

print_loop:

      li $t0,0
      la $t1, array


start:
      beq $t0,$s0,end
      lw $t2,($t1)
      addi $t1,$t1,4
      addi $t0,$t0,1

      li $v0,1
      move $a0,$t2
      syscall

      li $v0, 4           
      la $a0, space    
      syscall 

      j start

end:
    li $v0, 10        
    syscall     







