	.text
# Generate a dynamically created array 
# Populate it in a subprogram
# Print it in another subprogram
# hüso heape numaralarý ekledin array tamam gibi kalan kýsmý pazar yap.

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
		
menu:
	move	$t0, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	
	li $v0,4
	la $a0,menuPrompt
	syscall
	
	li $v0,5
	syscall
	
	move	$t5, $v0
	
	move	$a0, $t0	# $t0: array pointer
	move	$a1, $t1	# $t1: array size
	
	jal printArray
	jal findFirst
	jal findSecond
	jal findThird
	jal findFour

			
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

#===============================================================
findFirst:

	add	$t6, $zero, $zero
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t3, 1
	j	test3
again3:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)

	beq	$a0, $t5, equal

continue:
	move	$a0, $t2
	addi	$t3, $t3, 1
	addi	$t0, $t0, 4
	
test3:	
	ble	$t3, $t1, again3
	move	$t2, $a0
	move	$a0, $t6
	li	$v0, 1
	syscall
	move	$a0, $t2
	jr	$ra		# Go back

equal:
	addi	$t6, $t6, 1
	j continue
	
#===============================================================

#===============================================================
findSecond:

	add	$t6, $zero, $zero
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t3, 1
	j	test4
again4:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)

	blt	$a0, $t5, less

continue2:
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

less:
	addi	$t6, $t6, 1
	j continue2
	
#===============================================================
#===============================================================
findThird:

	add	$t6, $zero, $zero
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t3, 1
	j	test5
again5:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)

	bgt	$a0, $t5, greater

continue3:
	move	$a0, $t2
	addi	$t3, $t3, 1
	addi	$t0, $t0, 4
	
test5:	
	ble	$t3, $t1, again5
	move	$t2, $a0
	move	$a0, $t6
	li	$v0, 1
	syscall
	move	$a0, $t2
	jr	$ra		# Go back

greater:
	addi	$t6, $t6, 1
	j continue3
	
#===============================================================

#===============================================================
findFour:

	add	$t6, $zero, $zero
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t7, 1
	j	test6
again6:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)

	div $a0, $t5
	mfhi $t4
	beq	$t4, $zero, divide

continue4:
	move	$a0, $t2
	addi	$t7, $t7, 1
	addi	$t0, $t0, 4
	
test6:	
	ble	$t7, $t1, again6
	move	$t2, $a0
	move	$a0, $t6
	li	$v0, 1
	syscall
	move	$a0, $t2
	jr	$ra		# Go back

divide:
	addi	$t6, $t6, 1
	j continue4
	
#===============================================================
	.data
arrayNumber:	.asciiz "Size: "
arrayEnter: .asciiz "Numbers:  "	
	

array: .space 80 # Allocate 80 bytes = space enough to hold 20 words

menuPrompt:	.asciiz "\n 1. Find the number of array members equal to N. \n 2. Find the number of array members less and greater than N.\n 3. Find the number of elements evenly divisible by N."
aPrompt:	.asciiz "The number of array members equal to N: "
bPrompt:	.asciiz "The number of array members less and greater than N: "
cPrompt:	.asciiz "The number of elements evenly divisible by N: "
exit:	.asciiz "The program is over."
endl:	.asciiz "\n"
