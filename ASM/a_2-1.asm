# Dadi Sasank Kumar-22CS10020
# Trilochan-22CS10048

.data

prompt1: .asciiz "Enter an integer : "
prompt2: .asciiz "\nQuotient:\n "
prompt3: .asciiz "\nReminder:\n "


.text
.globl main
main:
    la $a0,prompt1
    li $v0,4
    syscall

    li $v0,5
    syscall 
    move $t0,$v0

    li $t3,255
    li $t1,0

    j program

program:

    blt $t0,$t3, exit #if input<255, exit
    srl $t4,$t0,8 #t4=t0/256 #t4=quotient
    sll $t5,$t0,24 #t5=t0*256 #t5=remainder
    srl $t5,$t5,24 #t5=t0%256 
    add $t1,$t1,$t4 #t1=t1+t4 

    beq $t5,$t3,update       #if t5=255, go to update

jumptomiddle:                         #if t5!=255,
    add $t0,$t4,$t5
    j program

update:              #if t5=255, t5=0
    move $t5,$zero #t5=0
    addi $t1,$t1,1 #t1=t1+1
    j jumptomiddle


exit:           
    la $a0,prompt2
    li $v0,4
    syscall

    move $a0,$t1
    li $v0,1  #print quotient
    syscall

    la $a0,prompt3
    li $v0,4
    syscall

    move $a0,$t0
    li $v0,1   #print remainder
    syscall

    li $v0,10
    syscall
