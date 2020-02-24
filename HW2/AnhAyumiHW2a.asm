#Ayumi Mutoh _ Anh Nguyen
    # Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:

   #create an array with 5 numbers
   addi $s0, $s0, 5
   addi $s1, $s1, 4
   addi $s2, $s2, 3
   addi $s3, $s3, 2
   addi $s4, $s4, 1
   
   #index $t0
   la $a0, arrayA
   sw $s0, 0($a0)
   sw $s1, 4($a0)
   sw $s2, 8($a0)
   sw $s3, 12($a0)
   sw $s4, 16($a0)
   
   
   # ask user "k" 
   addi $a1, $a1, 6
   
   
###print out the original array with while loop######

  li  $v0, 4
  la  $a0, OriArray
  syscall
  
  li $v0, 4
  la $a0, newLine
  syscall
  
  
   #index $t0 to 0
  li $t0, 0
   
while:
   beq $t0, 20, exit
   lw $t1, arrayA($t0)
   
   li $v0, 1
   move $a0, $t1 
   syscall 
   
   #print a new line
   li $v0, 4
   la $a0, newLine
   syscall
   
   add $t0, $t0, 4
   
   j while
   
exit: 
   li $v0, 4
   la $a0, newLine
   syscall 
#################################################
   
  # go to sort function 
   jal sort
   
# print sorted array #

   li  $v0, 4
   la  $a0, SortArray
   syscall
  
   li $v0, 4
   la $a0, newLine
   syscall
  
   lw $t0, 0($a0)
   lw $t1, 4($a0)
   lw $t2, 8($a0)
   lw $t3, 12($a0)
   lw $t4, 16($a0)
   
   li $v0, 1
   move $a0, $t0
   syscall
   li $v0, 4
   la $a0, newLine
   syscall
   
   li $v0, 1
   move $a0, $t1
   syscall
   li $v0, 4
   la $a0, newLine
   syscall
   
   li $v0, 1
   move $a0, $t2
   syscall
   li $v0, 4
   la $a0, newLine
   syscall
   
   li $v0, 1
   move $a0, $t3
   syscall
   li $v0, 4
   la $a0, newLine
   syscall
   
   li $v0, 1
   move $a0, $t4
   syscall
   li $v0, 4
   la $a0, newLine
   syscall
   
   
   li $v0, 10  #set $v0 to '10' to select exit syscall
   syscall  #exit


##############################################
         
sort:  
         #saving registers
         addi $sp, $sp, -20      # make room on stack for 5 registers
         sw   $ra, 16($sp)       # save $ra on stack
         sw   $s3, 12($sp)       # save $s3 on stack
         sw   $s2, 8($sp)        # save $s2 on stack
         sw   $s1, 4($sp)        # save $s1 on stack
         sw   $s0, 0($sp)        # save $s0 on stack 
         # procedure body 
         move $s2, $a0           # save $a0 into $s2
         move $s3, $a1           # save $a1 into $s3
         move $s0, $zero         # i = 0
for1tst: slt  $t0, $s0, $s3      # $t0 = 0 if $s0 ? $s3 (i ? n)
         beq  $t0, $zero, exit1  # go to exit1 if $s0 ? $s3 (i ? n)
         addi $s1, $s0, -1       # j = i – 1
for2tst: slti $t0, $s1, 0        # $t0 = 1 if $s1 < 0 (j < 0)
         bne  $t0, $zero, exit2  # go to exit2 if $s1 < 0 (j < 0)
         sll  $t1, $s1, 2        # $t1 = j * 4
         add  $t2, $s2, $t1      # $t2 = v + (j * 4)
         lw   $t3, 0($t2)        # $t3 = v[j]
         lw   $t4, 4($t2)   # $t4 = v[j + 1]
         slt  $t0, $t4, $t3      # $t0 = 0 if $t4 >= $t3
         beq  $t0, $zero, exit2  # go to exit2 if $t4 >= $t3
         move $a0, $s2           # 1st param of swap is v (old $a0)
         move $a1, $s1           # 2nd param of swap is j
         jal  swap               # call swap procedure
swap:    
         sll $t1, $a1, 2         # reg $t1 = k*4
         add $t1, $a0, $t1       # reg $t1 = v + (k * 4)
                                 # reg $t1 has the address of v[k]
         lw  $t0, 0($t1)         # reg $t0 (temp) = v[k]
         lw  $t2, 4($t1)         # reg $t2 = v[k + 1]
                                 # refers to next element of v
         sw  $t2, 0($t1)         # v[k] = reg $t2
         sw  $t0, 4($t1)         # v[k+1] = reg $t0 (temp)
         addi $s1, $s1, -1       # j –= 1
         j    for2tst            # jump to test of inner loop
exit2:   addi $s0, $s0, 1        # i += 1
         j    for1tst            # jump to test of outer loop
exit1: 
         # restoring registers
         lw   $s0, 0($sp)        # restore $s0 from stack
         lw   $s1, 4($sp)        # restore $s1 from stack
         lw   $s2, 8($sp)        # restore $s2 from stack
         lw   $s3, 12($sp)       # restore $s3 from stack
         lw   $ra, 16($sp)       # restore $ra from stack
         addi $sp, $sp, 20       # restore stack pointer
         
         jr   $ra                # return to calling routine

   
.data
   arrayA:  .space 20
   newLine: .asciiz "\n"
   list:    .word 5, 4, 3, 2, 1
   OriArray: .asciiz "The original array is: "
   SortArray: .asciiz "The sorted array is: "
