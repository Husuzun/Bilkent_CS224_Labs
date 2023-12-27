
.text 	

	li	$t0, 0
	li	$t1, 3
	li	$t2, 32
	
	la	$a0, input
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s2, $v0
	
	la $a0, instructionCount
	la $a1, end
	
	jal instructionCount
	
	add $s3, $v0, $zero
	
	li $v0,4
	la $a0, numberReg
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
		
	li $v0, 10
	syscall

#######################################################

instructionCount: 

	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)	
	
	while:
		
		bge $a0,$a1, done
		
		lw $s5, 0($a0)
		srl $s1, $s5, 26
		
		beq $s1, $zero, rCounter
		ble $s1, $t1, jCounter
iCounter:	
		srl	$s1, $s5, 16
		div	$s1, $t2
		mfhi	$s1
		bne	$s1, $s2, notAdder1
		addi $s3, $s3, 1
	notAdder1:
		srl	$s1, $s5, 21
		div	$s1, $t2
		mfhi	$s1
		bne	$s1, $s2, notAdder2
		addi $s3, $s3, 1
	notAdder2:
		addi $a0,$a0, 4
		j 	while
rCounter:
		srl	$s1, $s5, 11
		div	$s1, $t2
		mfhi	$s1
		bne	$s1, $s2, notAdder3
		addi $s3, $s3, 1
	notAdder3:
		srl	$s1, $s5, 16
		div	$s1, $t2
		mfhi	$s1
		bne	$s1, $s2, notAdder4
		addi $s3, $s3, 1
	notAdder4:
		srl	$s1, $s5, 21
		div	$s1, $t2
		mfhi	$s1
		bne	$s1, $s2, notAdder5
		addi $s3, $s3, 1
	notAdder5:
		addi $a0,$a0, 4
		j 	while
jCounter:	
		addi $a0,$a0, 4
		j 	while

	done: 	
		add $v0, $s3, $zero		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		
		addi $sp, $sp, 24
end:	jr $ra
	




.data

	main: .asciiz "For main program"
	subProg: .asciiz "For the subprogram"
	numberReg: .asciiz "The number of register: "
	newLine: .asciiz "\n"
	input: .asciiz "Input: \n"









