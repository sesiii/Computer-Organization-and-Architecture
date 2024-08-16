.data

prompt1: .asciiz "Enter a number: "
promp2: .asciiz "Sequence: "
newline: .asciiz "\n\n"
space: .asciiz " "
array: .space 10000

.text
.globl main
main:
      li $v0,4
      la $a0,prompt1
      syscall

      li $v0,5
      syscall
      move $t0,$v0  #num is in $t0

      li $v0,4
      la $a0,newline
      syscall

      li $t1,0
      li $t2,1

      li $v0,1
      move $a0,$t1 #prints 0
      syscall

      li $v0,4
      la $a0,space
      syscall

      beq $t0, 1, end

      li $v0,1
      move $a0,$t2 # prints 1
      syscall

      li $v0,4
      la $a0,space
      syscall
      
      li $t3,2 # counter till num
      la $t4, array # base address

fibonacci_sequence:
      bge $t3,$t0, end 
      add $t5,$t1,$t2
      #sw $t5, ($t4)

      #addi $t4,$t4,4
      

      li $v0,1
      move $a0,$t5 #prints the number
      syscall

      li $v0,4
      la $a0,space
      syscall

      move $t1,$t2 #now $t1 has value of $t2
      move $t2,$t5 #now $t2 has value of $t5
      
      addi $t3,$t3,1
      j fibonacci_sequence

      

end:
      li $v0, 10          
      syscall             

