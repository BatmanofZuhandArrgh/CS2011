# Simple routine to demo a loop
# Compute the sum of N integers: 1 + 2 + 3 + ... + N
# From: http://labs.cs.upt.ro/labs/so2/html/resources/nachos-doc/mipsf.html

	.text

	.globl	main
main:

	li $t1, 1 # value for North
	li $t2, 2 # value for South
	li $t3, 3 # value for East
	li $t4, 4 # value for West
	Loop:
	# Print msg1
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg1	
	syscall
		
	# Get N from user and save
	li	$v0,5		# read_int syscall code = 5
	syscall	
	move	$t0,$v0		# syscall results returned in $v0

	bne $t0, $t1, L2
	la $t5, goNorth
	j   exit
	
	L2:
	bne $t0, $t2, L3
	la $t5, goSouth
	j   exit
	
	L3:
	bne $t0, $t3, L4
	la $t5, goEast
	j   exit
	
	L4:
	bne $t0, $t4, Else
	la $t5, goWest
	j   exit
	
	Else: 
	la $t5, goDone
	j Done

	# Exit routine - print msg2
exit:	li	$v0, 4		# print_string syscall code = 4
	la	$a0, 0($t5)
	syscall

	# Print newline
	li	$v0,4		# print_string syscall code = 4
	la	$a0, lf
	syscall

	j   Loop
	
Done:	li	$v0, 4		# print_string syscall code = 4
	la	$a0, 0($t5)
	syscall
	
	li	$v0,10		# exit
	syscall

	# Start .data segment (data!)
	.data
msg1:	.asciiz	"Go North(1), South(2), East(3), West(4) or quit (any other character)  "
goNorth: .asciiz "Going North"
goSouth: .asciiz "Going South"
goEast: .asciiz "Going East"
goWest: .asciiz "Going West"
goDone: .asciiz "Done Going"
lf:     .asciiz	"\n"
