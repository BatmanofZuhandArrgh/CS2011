# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 	
		
	# Start allocating the array
	#1a. Creating an array with 5 numbers in it
	main:
	##1.a
	#1. Storing 5 numbers into 5 registers
	addi $s0, $s0, 2
	addi $s1, $s1, 29
	addi $s2, $s2, 2020
	addi $s3, $s3, 11
	addi $s4, $s4, 0
	
	#2. Creating an array
	la	$t0, array1
	li $t0, 0			#Setting the index to 0
	add	$t0, $t0, 4		#Adding 4 spaces into $t0
	sw	$s0, array1($t0)	#Storing s0 into the RAM in array(0)
	add	$t0, $t0, 4
	sw	$s1, array1($t0)
        add	$t0, $t0, 4
	sw	$s2, array1($t0)	
	add	$t0, $t0, 4
	sw	$s3, array1($t0)	
	add	$t0, $t0, 4
	sw	$s4, array1($t0)
	
	##1.b
	#3. Creating a second array
	la	$t1, array2
	
	##1.c
	#4. Load up the constants from the first array into the register
	li $t0, 0			#Setting the index to 0
	add	$t0, $t0, 4
	lw $t1, array1($t0)
	add	$t0, $t0, 4
	lw $t2, array1($t0)
	add	$t0, $t0, 4
	lw $t3, array1($t0)
	add	$t0, $t0, 4
	lw $t4, array1($t0)
	add	$t0, $t0, 4
	lw $t5, array1($t0)
	
	##1.d
	#5.Populate the second array
     	li $t0, 0			#Setting the index to 0
	add	$t6, $t1, $t2		#B[0] = A[0] + A[1]
	add	$t7, $t2, $t3		#B[1] = A[1] + A[2]
	add	$t1, $t3, $t4		#B[2] = A[2] + A[3]
	add	$t2, $t4, $t5		#B[3] = A[3] + A[4]
	

	add	$t0, $t0, 4		#Adding 4 spaces into $t0
	sw	$t6, array2($t0)	#Storing s0 into the RAM in array(0)
	add	$t0, $t0, 4
	sw	$t7, array2($t0)
        add	$t0, $t0, 4
	sw	$t1, array2($t0)	
	add	$t0, $t0, 4
	sw	$t2, array2($t0)	
	
	
        li $v0, 4 # Sets $v0 to "4" to output
	syscall # Exit
	.data
array1: .space 20
array2: .space 16
Else: .asciiz "Not 2"
