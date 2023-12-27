

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
.globl __start
 
__start:		# execution starts here

	la 	$a0,	aPrompt	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall
	
	move	$a1, $v0
	la 	$a0,	bPrompt	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall

	move 	$a0, $v0
	jal equation		# call fib
	
	move $a0,$v0	# print result
	li $v0, 1
	syscall

	la $a0,endl	# print newline
	li $v0,4
	syscall

	li $v0,10
	syscall		# bye bye

#------------------------------------------------

equation:

	add	$a2, $a1, $a0
	addi	$a2, $a2, 4
	mul 	$a3, $a1, 2
	div	$a2, $a3
	mflo	$a0
	move 	$v0, $a0
	jr 	$ra

#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
	aPrompt:	.asciiz "\n A: "
	bPrompt:	.asciiz "\n B: "
endl:	.asciiz "\n"

##
## end of Program3.asm
