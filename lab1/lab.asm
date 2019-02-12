		.data
		array: .space 400	
		x: .word 20
		temp:	.word 0
		
		space : .asciiz " "
		
		askSize: .asciiz "Enter array size which is less than or equal to 20: \n"
		ask: .asciiz "Enter the elements: \n "
		
		input: .asciiz "Enter an element \n"
		Menu: .asciiz "\n Welcome to menu \n"
		
		Option1: .asciiz " 1.	Find summation of numbers stored in the array which is greater than an input number \n"
		Option2:  .asciiz " 2.	Find summation of even and odd numbers and display them. \n"
		Option3: .asciiz " 3. Display the number of occurrences of the array elements divisible by a certain input number. \n"
		Option4: .asciiz "4. Quit \n"
		Choose: .asciiz "Enter the option you want to execute \n"
		
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
  		li $v0, 4                 
  		la $a0, ask
  		syscall
		li $v0, 5
		syscall
		sw $v0, 0($t8)
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

		la $t8, array
		subi $t3, $s0, 1 #last index 
		mul $t3, $t3, 4
		add $t3, $t3, $t8 #swap
		
	printReverse:
		
 		bge $t8, $t3 , endReverse
  		lw $t4, 0($t8) #temporary location for beginning
  		lw $t5, 0($t3) #
  		sw $t5, 0($t8) #take the values of beginning to end : swap
  		sw $t4, 0($t3)

		addi $t8, $t8, 4 
		addi $t3, $t3, -4
		j printReverse
		
	endReverse:	
		li $t1, 0
		la $t8, array
	print2:
		beq $t1, $s0 , endPrint2	
		lw $t2, 0($t8)		
		li $v0, 1
		la $a0, ($t2)
		syscall
		add $t1, $t1, 1
		add $t8, $t8, 4
		j print2
	endPrint2:
		
	menu: 
	li $v0,4
	la $a0, Menu
	syscall
	li $v0,4
	la $a0, Option1
	syscall
	li $v0,4
	la $a0, Option2
	syscall
	li $v0,4
	la $a0, Option3
	syscall
	li $v0,4
	la $a0, Option4
	syscall
	li $v0,4
	la $a0, Choose
 	syscall
	li $v0, 5
	syscall
	
		
	beq $v0,1, partA
	j partA
	beq $v0,2, partB
	j partB
	beq $v0,3, partC
	j partC
	beq $v0,4, quit
	j quit
	
	
	partA:
	li $v0, 4        # ask input
  	la $a0, input
 	syscall
	li $v0, 5
	syscall
	move $s5, $v0
	
	la $t8, array
	
	
	li $t1, 0 #i
	li $s7, 0 #sum
	
	for: 
		beq $t1, $s0 , end	
		lw $t2, 0($t8)			
		bgt $s5, $t2, else # 
		add $s7, $s7, $zero #sum = sum
	else:		
		add $s7, $s7, $t2 #sum = sum + x
		add $t1, $t1, 1
		add $t8, $t8, 4
		
		j for
		
	end:
		
 		li $v0, 1       
		syscall 
 		 
 		 j menu
 		 
	
	
	partB:
		
 		li $s1, 0 #sum of even is 0
 		li $s3, 0 #sum of odd is 0
		li $t1, 0 #i
		la $t8, array
   
 	forSumEvenOdd: 
		beq $t1, $s0 , end	
		lw $t2, 0($t8)
 	  		  	
   	 whileSub:   	
    		sub $t2, $t2, 2 #subtract 2 from the difference everytime till it is less than 2   	 
    		li  $v0, 1     	      	
   		syscall
   		bgt $t2, 2, whileSub 	 
    	if:
    		bne $t2, 1, elseSub
    		
		add $s1, $s1, $t1 #sum = sum + x
		li  $v0, 1     	      	
   		syscall
    		
	elseSub:
		add $s3, $s3, $t1
		li  $v0, 1     	      	
   		 syscall	
		
		add $t1, $t1, 1
		add $t8, $t8, 4
		 
		j forSumEvenOdd
     		
	endB:
	  j menu
	
	partC:
	
	li $v0, 4        # ask input
  	la $a0, input
 	syscall
	li $v0, 5
	syscall
	move $t9, $v0
	li $t1, 0 #i
	la $t8, array
	
	forOccurence:
		
		lw $t2, 0($t8)
		bge $t1, $s0 ,endOccur #counting adress
		lw $t2, array($t8) #load the number
		
		
	WhileOccur:	
		sub $t1, $t1, $t9 #subtract  the input from the difference everytime till it is less than input 	 
    		li  $v0, 1     	      	
   		 syscall
   		bgt $t1, $t9, WhileOccur
   		
   		bne $t1, 0, endOccur
   		add $s0, $s0, 1
   		li $v0,1
   		syscall
   		
	endOccur:
	 j menu
	 	
	
	quit:
		li $v0, 10
		syscall
	
	
