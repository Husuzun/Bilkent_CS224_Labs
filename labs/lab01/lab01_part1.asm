# CS224
# Lab 01
# Section 03
# Huseyin Uzun
# 21702559
# 04.10.2023

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
.globl __start
 
__start:		# execution starts here

	la 	$a0,	bPrompt	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall
	
	move	$s1, $v0
	la 	$a0,	cPrompt	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall

	move 	$s2, $v0
	la 	$a0,	dPrompt	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall

	move 	$s3, $v0
	jal equation		# call fib
	
	la $a0,result	# print newline
	li $v0,4
	syscall
	move 	$a0, $s4	# print result
	li $v0, 1
	syscall

	la $a0,endl	# print newline
	li $v0,4
	syscall

	li $v0,10
	syscall		# bye bye

#------------------------------------------------

equation:
	li 	$s4, 0
	mul 	$s4, $s1, $s3
	srl 	$s4, $s4, 1
	addi	$s4, $s4, 5
	sub	$s4, $s4, $s1
	div	$s4, $s2
	mfhi	$s4
	jr 	$ra

#################################
#					 	#
#     	 data segment		#
#						#
#################################

.data
	bPrompt:	.asciiz "\n B: "
	cPrompt:	.asciiz "\n C: "
	dPrompt:	.asciiz "\n D: "
	result:		.asciiz "\n Result: "
	endl:		.asciiz "\n"

##
## end of Program3.asm
