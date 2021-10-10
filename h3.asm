# Logan Larson

.data
array: .word 0:20
prompt: .asciiz "Enter an integer: "
max: .asciiz "How many integers would you like to enter: "

.text

#####
# Main calls necessary functions and exits
main:
# Prompt user for amount of integers
la $a0, max
li $v0, 4
syscall
li $v0, 5
syscall

# Setup parameters for readArray
la $a0, prompt
la $a1, array
la $a2, ($v0)
j readArray

# Setup parameters for insertionSort
insParam: la $s0, ($v0)
la $a0, array
la $a1, ($s0)
j insertionSort

# Setup parameters for printArray
prntParam: la $a0, array
la $a1, ($s0)
li $t0, 0
li $t1, 0
j printArray

exit: li $v0, 10
syscall
#####


#####
# Reads in values from user and stores into array
readArray: beq $t0, $a2, exitReadArray
li $v0, 4 # Prompt user to enter number
syscall
li $v0, 5 # Read input from user
syscall
sw $v0, array($t1) # Store input from user
addi $t1, $t1, 4
addi $t0, $t0, 1
j readArray

exitReadArray: la $v0, ($a2) # Put number of values entered in $v0
j insParam
#####


#####
# $a0 = addr of array | $a1 = size of array
insertionSort: li $t0, 1 # i counter
li $t1, 4 # i array pos
li $t2, 0 # j
li $t3, 0 # k
for: beq $t0, $a1, prntParam # For loop conditional
addi $t2, $t0, -1
lw $t3, array($t1)
addi $t5, $t1, -4 # j array pos
	while: blt $t2, 0, exitWhile # 1st part of conditional
	lw $t4, array($t5)
	ble $t4, $t3, exitWhile      # 2nd part of conditional
	addi $t6, $t5, 4
	sw $t4, array($t6)
	addi $t5, $t5, -4 # Increment while loop
	addi $t2, $t2, -1
	j while
exitWhile: addi $t5, $t5, 4
sw $t3, array($t5)
addi $t0, $t0, 1 # Increment for loop
addi $t1, $t1, 4
j for
#####


#####
printArray: beq $t0, $a1, exit
lw $a0, array($t1)
li $v0, 1
syscall
addi $t0, $t0, 1
addi $t1, $t1, 4
j printArray
#####