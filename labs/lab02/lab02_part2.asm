
	.text
# CS224
# lab02_par	t01
# Section 03
# Hüseyin Uzun
# 21702559
# 11.10.2023

menu:	
	la 	$a0,	menuPrompt	#
	li 	$v0,	4	#
	syscall
	move	$t0, $v0
	
	li	$v0, 5
	syscall
	li 	$t1,	1
	li 	$t2,	2
	
	beq	$t0, $t2, exitProgram	
	la 	$a0,	intNumber1	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall
	move	$s0, $v0

	# s0 first register, s1 second register
	
		
	move 	$a0,	$s0	# output prompt message on terminal
	li 	$v0,	34	# syscall 4 prints the string
	syscall
	
	la 	$a0,	nLine	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	jal 	reverseReg
	move 	$a0, $s5
	li 	$v0,	34	# syscall 4 prints the string
	syscall
	
	la 	$a0,	nLine	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	j menu
	
# stop
exitProgram:

	li $v0,4
	la $a0,exit
	syscall
	
	li	$v0, 10
	syscall

#===============================================================
reverseReg:
	li 	$s4, 2
	li	$t3, 0
	li	$t4, 31
	move	$a0 , $s0
	add	$s5, $zero, $zero
again9:

	div 	$a0 , $s4
	mfhi 	$s6
	mflo	$s2
	move 	$a0, $s2
	add	$s5, $s5, $s6
	beq 	$t3, $t4, end9
	addi	$t3, $t3, 1
	mul	$s5, $s5, $s4
	j again9
	
end9:
	jr 	$ra
#===============================================================

	.data
menuPrompt:	.asciiz "\n(1) Reverse number.\n(2) Exit. \nChoose:"
intNumber1:	.asciiz "Enter integer: "
intNumber2:	.asciiz "Enter integer: "
arrayEnter: .asciiz "number:  "	
sizePrint1: .asciiz "\nNumbers:   \n"
sizePrint2: .asciiz "\nNumbers:   \n"
diffPrint1: .asciiz "\nDistance:  \n"
nLine: .asciiz "\n"
array1: .asciiz "initialize first array\n"
array2: .asciiz "initialize second array\n"


array: .space 80 # Allocate 80 bytes = space enough to hold 20 words

exit:	.asciiz "The program is over."
endl:	.asciiz "\n"
