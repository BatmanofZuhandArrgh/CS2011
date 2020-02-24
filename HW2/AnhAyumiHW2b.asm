# AyumiMutoh _ Anh Nguyen
# Compute several Fibonacci numbers and put in array, then print
.data
fibs:.word   0 : 19         # "array" of words to contain fib values
size: .word  19             # size of "array" (agrees with array declaration)
prompt: .asciiz "How many Fibonacci numbers to generate? (2 <= x <= 19)"

.text
      la   $a0, fibs        # load address of array
      la   $s5, size        # load address of size variable
      lw   $s5, 0($s5)      # load array size

# Optional: user inputs the number of Fibonacci numbers to generate
pr:   
      li   $v0, 4           # specify Print String service
      la   $a0, prompt      # load address of prompt for syscall
      syscall               # print the prompt string
      li   $v0, 5           # Replace_this_dummy_with_the_correct_numeric_value???????           # specify Read Integer service
      syscall               # Read the number. After this instruction, the number read is in $v0.
      bgt  $v0, $s5, pr     # Check boundary on user input -- if invalid, restart
      blt  $v0, $zero, pr   # Check boundary on user input -- if invalid, restart
      add  $a1, $v0, $zero  # transfer the number to the desired register
      
      li $a0, 0           # i = 0
      
      jal fib               # call fibonacci function
      
      move $t3, $v0
      
      move $a0, $t3
      li   $v0, 1
      syscall 
      
      # The program is finished. Exit.
      li   $v0, 10          # system call for exit
      syscall               # Exit!
      
fib:
      bgt  $a1, 1, recurse
      move $v0, $a1
      jr   $ra
recurse:
      sub  $sp, $sp, 12
      sw   $ra, 0($sp) 
      
      sw   $a1, 4($sp)
      addi $a1, $a1, -1
      jal  fib
      lw   $a1, 4($sp)
      sw   $v0, 8($sp)
      
      addi $a1, $a1, -2
      jal  fib
      
      lw   $t0, 8($sp)
      add  $v0, $v0, $t0
      
      lw   $ra, 0($sp)
      addi $sp, $sp, 12
      jr   $ra
      
