# CS224
# Lab 01
# Section 03
# Huseyin Uzun
# 21702559
# 04.10.2023


	.text
# Generate a dynamically created array 
# Populate it in a subprogram
# Print it in another subprogram

	la 	$a0,	arrayNumber	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall
	
	move	$a0, $v0
	move	$a1, $a0
	li	$v0, 9
	syscall
	# Array beginning address is in $v0
	
# Populate array in subprogram populateArray
	move	$a0, $v0	# $vo contains the beginning address of array
	li $v0, 4
	
	jal	populateArray
# Print array in subprogram printArray
	jal	printArray
		
	move	$t0, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	
	jal	swapArray
	
	move	$t0, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	
	la 	$a0,	menuPrompt	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	move	$a0, $t0	# $t0: array pointer
	move	$a1, $t1	# $t1: array size
	
	jal	printArray
	
	la 	$a0,	endl	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
# stop
exitProgram:

	li $v0,4
	la $a0,exit
	syscall
	
	li	$v0, 10
	syscall
#===============================================================
populateArray:
	move	$t0, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	

	li	$t3, 1
	j	test
again:	
	move $a3, $a0
	la $a0, arrayEnter	# output prompt message on terminal
	li $v0,4	# syscall 4 prints the string
	syscall
	move $a0, $a3
	li	$v0, 5
	syscall
	sw	$v0, 0($t0)
	addi	$t3, $t3, 1
	addi	$t0, $t0, 4
	
test:	
	ble	$t3, $t1, again
	jr	$ra		# Go back
#===============================================================
printArray:
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t3, 1
	j	test2
again2:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)
	li	$v0, 1
	syscall
	move	$a0, $t2
	addi	$t3, $t3, 1
	addi	$t0, $t0, 4
	
test2:	
	ble	$t3, $t1, again2
	jr	$ra		# Go back
#===============================================================

swapArray:
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	move	$t4, $a1
	mul	$t4, $t4, 4
	subi	$t4, $t4, 4
	add	$t4, $t4, $t0
	addi	$t3, $t0, 0
	j	test3
again3:	
# Print array element pointed by $t0.
	lw	$t5, 0($t3)
	lw	$t6, 0($t4)
	sw	$t6, 0($t3)
	sw	$t5, 0($t4)
	addi	$t3, $t3, 4
	subi	$t4, $t4, 4
	
test3:	
	blt	$t3, $t4, again3
	jr	$ra		# Go back
#===============================================================

	.data
arrayNumber:	.asciiz "Size: "
arrayEnter: .asciiz "Numbers:  "	
	

array: .space 80 # Allocate 80 bytes = space enough to hold 20 words

menuPrompt:	.asciiz "\nThe swapped array: "
exit:	.asciiz "The program is over."
endl:	.asciiz "\n"
