	.text
P1:
addi $v0, $zero, 5
addi $v1, $zero, 0x000C
addi $a3, $v1, 0xFFF7
or $a0, $a3, $v0
and $a1, $v1, $a0
add $a1, $a1, $a0
beq $a1, $a3, P2
slt $a0, $v1, $a0
beq $a0, $zero, P1
P2:
addi $a1, $zero, 0x0000
J1:
slt $a0, $a3, $v0
J2:
add $a3, $a0, $a1
sub $a3, $a3, $v0
sw $a3, 68($v1)
lw $v0, 80($zero)
j J1
addi $v0, $zero, 0x0001
sw $v0, 0x0054($zero)
j J2

#=========================================================		
	.data
line:	
	.asciiz "\n --------------------------------------"
enterKey:
	.asciiz	"\n Enter key: "
	
enterData:
	.asciiz	"\n Enter data: "

howManyNode:
	.asciiz	"\n Enter Number of Node: "
	
nodeNumberLabel:
	.asciiz	"\n Node No.: "
	
addressOfCurrentNodeLabel:
	.asciiz	"\n Address of Current Node: "
	
addressOfNextNodeLabel:
	.asciiz	"\n Address of Next Node: "

keyValueOfCurrentNode:
	.asciiz	"\n Key Value of Current Node: "
	
dataValueOfCurrentNode:
	.asciiz	"\n Data Value of Current Node: "
