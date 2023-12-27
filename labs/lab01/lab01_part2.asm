	.text

	la 	$a0,	arrayNumber	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	
	li	$v0, 5
	syscall
	
	move	$a0, $v0
	move	$a1, $a0
	li	$v0, 9
	syscall
	li	$s7, 4
	li	$s6, 3
	li	$s5, 2
	li	$s4, 1
	li	$s3, 0
	# Array beginning address is in $v0
	
# Populate array in subprogram populateArray
	move	$a0, $v0	# $vo contains the beginning address of array
	li $v0, 4
	
	jal	populateArray
# Print array in subprogram printArray
	jal	printArray
		
menu:
	move	$t0, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	
	li $v0,4
	la $a0,menuPrompt
	syscall
	
	li	$v0, 5
	syscall
	move	$a0, $t0	# $t0: array pointer
	move	$a1, $t1	# $t1: array size
	
	beq $v0, $s3, findMax
	beq $v0, $s4, findMaxNumber
	beq $v0, $s5, findDiv
	beq $v0, $s6, exitProgram
	beq $v0, $s7, printArray

			
	jal menu
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
findMax:

	add	$t6, $zero, $zero
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t3, 1
	j	test3
again3:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)

	bgt	$a0, $t6, equal

continue3:
	move	$a0, $t2
	addi	$t3, $t3, 1
	addi	$t0, $t0, 4
	
test3:	
	ble	$t3, $t1, again3
	move	$t2, $a0
	move	$a0, $t6
	move	$s1, $a0  #bulduðun maxý t5e eþitle
	li	$v0, 1
	syscall
	move	$a0, $t2
	
	jr	$ra		# Go back

equal:
	add	$t6, $a0, $zero
	j continue3

#===============================================================

#===============================================================
findMaxNumber:

	add	$t6, $zero, $zero
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t3, 1
	j	test4
again4:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)

	beq	$a0, $s1, equal2

continue4:
	move	$a0, $t2
	addi	$t3, $t3, 1
	addi	$t0, $t0, 4
	
test4:	
	ble	$t3, $t1, again4
	move	$t2, $a0
	move	$a0, $t6
	li	$v0, 1
	syscall
	move	$a0, $t2
	jr	$ra		# Go back

equal2:
	addi	$t6, $t6, 1
	j continue4

#===============================================================
findDiv:

	add	$t6, $zero, $zero
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t7, 1
	j	test5
again5:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)

	div $s1, $a0
	mflo $t3
	mfhi $t4
	beq	$t3, $s4 , continue7
	beq	$t4, $zero, divide
continue7:
continue6:
	move	$a0, $t2
	addi	$t7, $t7, 1
	addi	$t0, $t0, 4
	
test5:	
	ble	$t7, $t1, again5
	move	$t2, $a0
	move	$a0, $t6
	li	$v0, 1
	syscall
	move	$a0, $t2
	jr	$ra		# Go back

divide:
	addi	$t6, $t6, 1
	j continue6
	
#===============================================================
	.data
arrayNumber:	.asciiz "Size: "
arrayEnter: .asciiz "Numbers:  "	
	

array: .space 400 # Allocate 80 bytes = space enough to hold 20 words

menuPrompt:	.asciiz "\n'0'. Find the maximum number stored in the array and display that number.\n'1'. Find the number of times the maximum number appears in the array. \n'2'. Find how many numbers we have that we can divide the maximum number.\n'3' Quit."
exit:	.asciiz "The program is over."
endl:	.asciiz "\n"
