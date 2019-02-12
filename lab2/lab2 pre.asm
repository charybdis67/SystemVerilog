		.text
		  
	  la   $a0, hexNo
	  move $t0, $a0
	  jal   convertHexToDec
	# result comes in $v0	
	  move $v0, $s2
	  li $v0, 1
	  syscall
	  j done
	  
convertHexToDec:
	 lb $t1, 0($t0)
	 beqz $t1, end2
	 bgt $t1, 48, end2	 
	 add $s2, $s2, $t1
	  lb $t2, 4($t0)
	 beqz $t2, end2
	 bgt $t2, 48, end2	 
	 add $s2, $s2, $t2 
	 jr $ra
	
end2:
	addi $s1, $s1, -1
	li $v0, 1
	add $a0, $s1, $zero
	syscall
	 
done:	   
	li $v0, 10      #ends program
	syscall
	
	  
	  
	  .data
hexNo:   .asciiz "2B"

