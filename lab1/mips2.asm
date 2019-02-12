.data
msg1: .asciiz "Enter the first number: "
msg2: .asciiz "Enter the second number: "
result: .asciiz "The result is: "
c: .word
d: .word 
x: .word 
a: .word
 
.text
 
li $v0,4 
la $a0,msg1
syscall
 
li $v0,5
la $t0,c
syscall


 
li $v0,4 
la $a0,msg1
syscall
 
li $v0,5
la $t0,d
syscall



sub $t0,c,d

li $v0,4
la $a0,result 
syscall
 
li $v0,1
move $a0,$t0
syscall
 
li $v0,10
syscall