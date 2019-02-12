.data
		array: .space 400	
		x: .word 20
		temp:	.word 0
		
		space : .asciiz " "
		newLine : " \n"
		askSize: .asciiz "Enter array size which is less than or equal to 20: \n"
		
		
	.text
	.globl main

	main:
		
 		li $v0, 4        # print askSize
  		la $a0, askSize
 		 syscall
		li $v0, 5
		syscall
		move $s0, $v0
		la $t8, array							
		li $t1, 0
	
	#ask elements
	
	while: 
		
		beq $t1, $s0 , endwhile
  		li $a0, 1
  		li $a1, 100
  		li $v0, 42
  		syscall
  		lw $a0, 0($s0)
  		li $v0, 1
  		syscall
		addi $t1, $t1, 1
		addi $t8, $t8, 4		
		j while
	endwhile:
		la $t8, array
		li $t1, 0
	print:
		beq $t1, $s0 , endPrint		
		lw $t2, 0($t8)		
		li $v0, 1
		la $a0, ($t2)
		syscall
		add $t1, $t1, 1
		add $t8, $t8, 4
		j print
		
		
		
	endPrint:	
  		
  		jal bubbleSort
  		
  	bubbleSort:
  		#$a0 = beginning of the array 
  		# array size = $a1
  		#array size can be 1 or more
  		move $a1, $s0 #move size to $a1
  		#base case 		
  		bgt $a1, $zero, quit 
  		la $t8, array
		subi $a1, $s0, 1 #last index 
		mul $a1, $a1, 4
		add $t3, $t3, $t8 #swap
		
	swap:
		
 		bge $t8, $a1 , print
  		lw $a0, 0($t8) #temporary location for beginning
  		lw $t5, 0($a1) #
  		sw $t5, 0($t8) #take the values of beginning to end : swap
  		sw $t4, 0($a1)
  		
  		addi $t8, $t8, 4
  		addi $a1,$a1,4
  		j swap
  		
	minMax:
		
		jal bubbleSort
		
		lw $t4, 0($a1)
		li $v0, 1
		syscall
		lw $t7, ($a1)
		li $v0, 1
		syscall
	
	noOfUniqueElements:
		add $t1, $a2, $zero     # $t1 = argument
addi $t2, $zero, 1      # $t2 = 1
loop2:
addi $t2, $t2, 1        # $t2++
beq $t2, $t1, true      # if $t2 == $t1, return
div $t3, $t1, $t2       # $t3 = $t1 / $t2
mfhi $t4                # $t4 = remainder
beq $t4, $zero, false
j loop2
false:
li $v1, 0       # $v1 = false
jr $ra
true:
li $v1, 1       # $v1 = true
jr $ra

		
	quit:
		li $v0, 10
		syscall
	