.text 
	.globl __main
__main:
  	  	
display:	
	la $a0, menu
	li $v0, 4
	syscall	
	
	li $v0, 5
	syscall

	beq $v0, 1, FRecursiveDivision
  	beq $v0, 2, exit
  	j display
  	
FRecursiveDivision:
	la $a0, first
	li $v0, 4
	syscall	
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	la $a0, second
	li $v0, 4
	syscall	
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	beq $t0, $zero, exit
	beq $t1, $zero, exit
	
	move $a0, $t0
	move $a1, $t1
	jal  recursiveDivision # call the subprogram	
	
	sw   $v0, result	
	sw   $v1, remain
	
	la $a0, quotientP
	li $v0, 4
	syscall	
	
	lw $a0, result
	li $v0, 1 
	syscall
	
	la $a0, remainderP
	li $v0, 4
	syscall	
	
	lw $a0, remain
	li $v0, 1 
	syscall
	
	j display		

exit:
    	li $v0, 10
	syscall	
	
recursiveDivision:
	addi $sp, $sp, -8
	sw   $a0, 4($sp)
	sw   $ra, 0($sp)  # push $ra value onto stack
	 
	blt $a0, $a1, quotient
	
	sub $a0, $a0, $a1
	jal  recursiveDivision  # recursive call to subprogram
	
	lw   $ra, 0($sp) 
	lw   $a0, 4($sp)
	addi $sp, $sp, 8   #$sp pop 2 items
	addi $v0, $v0, 1 # add result to $v0
	jr   $ra
	
quotient:
	move $v1, $a0	
	li $v0, 0
	addi $sp, $sp, 8 #$sp pop 2 items
	jr   $ra	
	
.data
result:		.word 0
remain:		.word 0
first:		.asciiz "Enter the first number: "
second:		.asciiz "Enter the second number: "
quotientP:	.asciiz "\nThe quotient is: "
remainderP:	.asciiz "\nThe remainder is: "
menu:		.asciiz "\n\nMenu:\n1. Recursive division\n2. Exit\n"
newLine:	.asciiz " \n"







