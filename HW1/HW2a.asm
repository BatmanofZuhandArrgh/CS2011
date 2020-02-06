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
	la	$t8, array2
	
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
	
	##2.
	#5.Populate the second array
	li $t0, 0			#Setting the index to 0
	li $t7, 0			#Setting the index to 0
     	li $t8, 0			#Setting the index to 0
     	li $t9, 0			#Setting the index to 0
	
Loop: 	li $t6, 0			#Initiating Spaceholder variable

	add	$t0, $t0, 4		#Adding 4 spaces into $t0
	lw $t7, array1($t0)		#Loading A[i] into $t7
	add	$t6, $t6, $t7		#Adding the A[i] into t6
	
	add	$t0, $t0, 4		#Adding 4 spaces into $t0
	lw $t7, array1($t0)		#Loading A[i] into $t7
	add	$t6, $t6, $t7		#Adding the A[i+4] into t6
	
	sub	$t0, $t0, 4		#Subtracting 4 spaces into $t0
	
	add	$t8, $t8, 4		#Adding 4 spaces into $t0
	sw	$t6, array2($t8)	#Storing 
	
	beq $t8, 16, Else
	j Loop
	
	
	Else:
	#6. Load up the constants from the first array into the register
	li $t8, 0			#Setting the index to 0
	add	$t8, $t8, 4
	lw $t1, array2($t8)
	add	$t8, $t8, 4
	lw $t2, array2($t8)
	add	$t8, $t8, 4
	lw $t3, array2($t8)
	add	$t8, $t8, 4
	lw $t4, array2($t8)

	
	.data
array1: .space 20
array2: .space 16
