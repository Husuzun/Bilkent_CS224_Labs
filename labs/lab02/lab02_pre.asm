	.text

	la 	$a0,	arrayNumber	# output prompt message on terminal
	li 	$v0,	4	# syscall 4 prints the string
	syscall
	la	$s7, FreqTable
	li	$v0, 5
	syscall
	
	move	$a0, $v0
	move	$a1, $a0
	li	$v0, 9
	syscall
	li	$s5, 2
	li	$s4, 1
	li	$s3, 0
	# Array beginning address is in $v0
	li	$t7, 10
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
	
	beq $v0, $s3, findFreq
	beq $v0, $s4, exitProgram
	beq $v0, $s5, printArray

			
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
findFreq:
	add	$t6, $zero, $zero
	li	$t7, 10
	move	$t0, $a0	# $t0: array pointer
	move	$t2, $a0	# $t0: array pointer
	move	$t1, $a1	# $t1: array size
	li	$t3, 1
	j	test4
again4:	
# Print array element pointed by $t0.
	move	$t4, $s7
	lw	$a0, 0($t0)
	blt	$a0, $t7, equal2 # eðer 10dan küçükse o adresi bir arttýrmak için equal 2ye git. 
	mul	$a0, $t7, 4
	add	$t4, $t4, $a0
	lw	$t6, 0($t4)
	addi	$t6, $t6, 1
	sw	$t6, 0($t4)
continue4:
	move	$a0, $t2
	addi	$t3, $t3, 1
	addi	$t0, $t0, 4
	
test4:	
	ble	$t3, $t1, again4
	move	$t2, $a0
	move	$a0, $t6
	move	$a0, $t2
	j printFreq
	jr	$ra		# Go back

equal2:
	mul	$a0, $a0, 4
	add	$t4, $t4, $a0
	lw	$t6, 0($t4)
	addi	$t6, $t6, 1
	sw	$t6, 0($t4)
	j continue4

#===============================================================
printFreq:
	move	$t0, $s7	# $t0: array pointer
	move	$t2, $s7	# $t0: array pointer
	move	$t1, $t7	# $t1: array size
	li	$t3, 0
	j	test3
again3:	
# Print array element pointed by $t0.
	lw	$a0, 0($t0)
	li	$v0, 1
	syscall
	move	$a0, $t2
	addi	$t3, $t3, 1
	addi	$t0, $t0, 4
	
test3:	
	ble	$t3, $t1, again3
	jr	$ra		# Go back
	
#===============================================================

#===============================================================
	.data
arrayNumber:	.asciiz "Size: "
arrayEnter: .asciiz "Numbers:  "	
	

array: .space 400 # Allocate 80 bytes = space enough to hold 20 words
FreqTable: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

menuPrompt:	.asciiz "\n'0'. Find the freqtable.\n'1'. exit. \n'2'. print.\n"
exit:	.asciiz "The program is over."
endl:	.asciiz "\n"
