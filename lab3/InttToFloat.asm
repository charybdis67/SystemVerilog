		.data 
	ask: .asciiz "Please enter a positive integer numbers" 
	continue: 
	a: .word 10
		.text

	
	li $v0, 4        # print ask question
  	la $a0, ask
 	syscall
	li $v0, 5
	syscall
	
	j printInt
	
	jal convert 
	j printInt
	

	
convert:
	add $t1, $t1, $0 #counter
	add $s1, $s1, 1 #and number
loop: 	
	move $s0, $a0 
	and $s2, $s1, $s0
	bne $s2, 0, loopEnd
	add $t1, $t1, 1
	sll $s0, $s0, 1
	
	b loop
loopEnd:
	sll $s0, $s0, 1
	add $t1, $t1,1 
	add $s4, $s4, $zero
	add $s4, $s4, $s0
	
	#mantissa
	srl $s0, $s0, 9
	add $t1, $t1, -32
	add $t1, $t1, 127
	
	#exponent
	sll $s4, $s4, 22
	add $s0, $s0, $s4
	
	b printfloat

printInt:
	#print the number
	move $a1, $v0
	li $v0, 1
	move $a0, $a1
	syscall
	

	
printfloat:
	mtc1 $s0, $f12
 	li $v0, 2
 	syscall


stop:	
	#stop
	li $v0, 10
	syscall
	
	
	
	
     
