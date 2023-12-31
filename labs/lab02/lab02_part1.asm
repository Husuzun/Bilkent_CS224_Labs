
	.text
# CS224
# lab02_pat01
# Section 03
# H�seyin Uzun
# 21702559
# 12.03.2023

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
	
	la 	$a0,	intNumber2	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall
	move	$s1, $v0

	# s0 first register, s1 second register
	
		
	move 	$a0,	$s0	# output prompt message on terminal
	li 	$v0,	34	# syscall 4 prints the string
	syscall
	
	la 	$a0,	nLine	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	move 	$a0,	$s1	# output prompt message on terminal
	li 	$v0,	34	# syscall 4 prints the string
	syscall
		
	la 	$a0,	diffPrint1	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	jal 	calculate
	move 	$a0, $s5
	li 	$v0,	1	# syscall 4 prints the string
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
calculate:
	li	$s5, 0  #diff
	li 	$s4, 16
	li	$t4, 8
	li	$t5, 0
	move	$a0 , $s0
	move	$a1 , $s1
	
again9:

	div 	$a0 , $s4
	mfhi 	$s6
	mflo	$s2
	move 	$a0, $s2
	
	div 	$a1 , $s4
	mfhi 	$s7
	mflo	$s3
	move 	$a1, $s3
	beq 	$t5, $t4, end9
	addi	$t5, $t5, 1
	beq	$s7, $s6, again9
diff:
	addi 	$s5, $s5, 1
	j again9
	
end9:
	jr 	$ra
#===============================================================

	.data
menuPrompt:	.asciiz "\n(1) Hamming Distance.\n(2) Exit. \nChoose:"	
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
