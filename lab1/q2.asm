	.data
		array: .space 80	
		x: .word 20
		space : .asciiz " "
		newLine: .asciiz "\n"
		askSize: .asciiz "Enter array size which is less than or equal to 20:"
		ask: .asciiz "Enter the elements: "
		warning: .asciiz "the size should be less than or equal to 20 "
	.text
	.globl main

	main:
		li $t1, 1 
		la $s0, array
 		 li $v0, 4        # print askSize
  		la $a0, askSize
 		 syscall
		li $v0, 5
		syscall
 		move $s2,$v0
 		lw $s1, x
		slt $t1,$s1,$s2      # checks if $s1 > $s2
 		li $v0, 4            # print askSize
 		la $a0, warning      #printing the warning 
 		 syscall
		li $v0, 5
		syscall
		beq $t1,1,main

	while: 
		beq $t1, $s2 , endwhile
  		li $v0, 4                 # we print space between each output
  		la $a0, ask
  		syscall
		li $v0, 5
		syscall
		sw $v0, 0($s0)
		addi $t1, $t1, 1
		addi $s0, $s0, 4
		j while

	endwhile:
	
	print:
		beq $t0, $s0, endPrint
		lw $t6, array( $t0)
		addi $t0, $t0, 4
		li $v0, 1                 
  		move $a0, $t6          
  		syscall 
		 li $v0, 4                 # we print space between each output
  		la $a0, space
  		syscall
  		bgt $t0,1, print
  		j print
  		
  	endPrint:

		li $v0, 4                 # we print space between each output
  		la $a0, newLine
  		syscall
  		
	printReverse:
		
 		addi $t1, $t1, -1         # counting  with -1
  		addi $s0, $s0, -4         # also counting down in address
  		li $v0, 1                 
  		lw $a0, 0($s0)            
  		syscall                   
 		 li $v0, 4                 # we print space between each output
  		la $a0, space
  		syscall
  		 bgt $t1, 0, printReverse    # if there is more element, continue print
 
		li $v0, 10
		syscall
		
