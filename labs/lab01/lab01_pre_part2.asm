# CS224
# Lab 01
# Section 03
# Hüseyin Uzun
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
	
	move	$a1, $v0
	la 	$a0,	cPrompt	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall
	
	move	$a2, $v0
	la 	$a0,	dPrompt	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall
	
	move	$a3, $v0
	jal equation		# call fib
continue:
	
	la $a0,result	# print newline
	li $v0,4
	syscall
	
	move $a0,$s3	# print result
	li $v0, 1
	syscall

	la $a0,endl	# print newline
	li $v0,4
	syscall

	li $v0,10
	syscall		# bye bye

#------------------------------------------------

equation:
	li 	$s0, 0
	move	$s1, $a1 #b
	move	$s2, $a2 #c
	jal	divi
	add	$s0, $s0, $s3
	move	$s1, $a3 #d
	move	$s2, $a1 #b
	jal	mod
	add	$s0, $s0, $s1
	sub	$s0, $s0, $a2
	move	$s1, $s0 #sonuc
	move	$s2, $a1 #b
	jal	divi
	j continue

mod:
	bgt	$s1, $s2, again
	jr	$ra
again:
	sub	$s1, $s1, $s2
	j mod

divi:
	li	$s3, 0
test2:
	bgt	$s1, $s2, again2
	jr	$ra
again2:
	sub	$s1, $s1, $s2
	addi	$s3, $s3, 1
	j test2

#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
	bPrompt:	.asciiz "\n B: "
	cPrompt:	.asciiz "\n C: "
	dPrompt:	.asciiz "\n D: "
	result:	.asciiz "\n Result: "
endl:	.asciiz "\n"

##
## end of Program3.asm
