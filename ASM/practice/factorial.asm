.data
num: .word 20
prompt1: .asciiz "Enter a number: "
prompt2: .asciiz "Factorial of number: "
newline: .asciiz "\n\n"
factorial_of_n: .word 1

.text
.globl main

main:
      # Print prompt1
      li $v0, 4
      la $a0, prompt1
      syscall

      # Read number
      li $v0, 5
      syscall
      sw $v0, num  # Store the input number in memory

      # Initialize the factorial calculation
      lw $t0, num   # Load the number into $t0
      li $t1, 1     # $t1 will hold the factorial result, start with 1

factorial:
      beqz $t0, end_factorial  # If $t0 is zero, exit the loop
      mul $t1, $t1, $t0        # $t1 = $t1 * $t0
      sub $t0, $t0, 1          # $t0 = $t0 - 1
      j factorial              # Repeat the loop

end_factorial:
      # Store the result in memory
      sw $t1, factorial_of_n

      # Print prompt2
      li $v0, 4
      la $a0, prompt2
      syscall

      # Print the factorial result
      lw $a0, factorial_of_n
      li $v0, 1
      syscall

      # Print newline
      li $v0, 4
      la $a0, newline
      syscall

      # Exit program
      li $v0, 10
      syscall
