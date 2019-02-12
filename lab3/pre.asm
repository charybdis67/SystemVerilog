		.data
			
		x: .word 20
		result:	.word 0
	
		
		space : .asciiz " "
		newLine : " \n"
		askSize: .asciiz "n:"
		
		
	.text
	.globl main

	main:
		
 		li $v0, 4        # print askSize
  		la $a0, askSize
 		 syscall
		li $v0, 5
		syscall
		move $a0, $v0
		jal recursiveSummation
		sw $v0, result
		
		#print sum
		li $v0, 4
		la $a0, result
		syscall
		
		li $v0, 4        # print askSize
  		la $a0, askSize
 		 syscall
		li $v0, 5
		syscall
		move $a0, $v0
		
		li $v0, 4        # print askSize
  		la $a0, askSize
 		 syscall
		li $v0, 5
		syscall
		move $a1, $v0
		jal recursiveMultiplication
		sw $v0, result
		
		#print sum
		li $v0, 4
		la $a0, result
		syscall
		
		

recursiveSummation:	
	
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	addi $t0, 0, 2
	slt $t0, $a0, $t0 #base case
	beq $t0, $0, sum
	addi $v0, $0, 1
	addi $sp, $sp, 8  
	jr   $ra           #return 
		
sum:
	addi $a0, $a0, -1
	jal recursiveSummation
	lw $a0, 4($sp)
	add $v0, $a0, $v0
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	
recursiveMultiplication:
	
	addi $sp, $sp, -12
	sw $a1, 8($sp)
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	addi $t0, 0, 2
	slt $t0, $a0, $t0 #base case
	beq $t0, $0, multi
	addi $v0, $0, 1
	addi $sp, $sp, 8  
	jr   $ra           #return 
		
multi:
	addi $a0, $a0, 0
	jal recursiveMultiplication
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	add $v0, $a0, $v0
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	
	
	
	
	
	
	