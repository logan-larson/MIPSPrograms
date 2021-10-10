# Logan Larson

.data
prmpt: .asciiz "Enter the number of elements (between 1 and 30) in the array: "
errorMsg: .asciiz "The number entered is not between 1 and 30.\n"
prmpt2: .asciiz "Enter "
prmpt3: .asciiz " positive integers:\n"
prmpt4: .asciiz "\nEnter a number or -1 to quit: "
notf: .asciiz "Not found"

array: .word 0:30

.text
# $t0 is actual number entered
# $t1 is counter to see if 3 numbers have been entered
# $t2 is the space needed for the array

## Getting size of array
li $t1, 3
j readNum
error: addi $t1, $t1, -1 # When num is outside range print error then prompt again
beqz $t1, exit
la $a0, errorMsg
li $v0, 4
syscall
readNum: la $a0, prmpt
li $v0, 4
syscall
li $v0, 5
syscall
bgt $v0, 30, error # If outside range, got to error
blt $v0, 1, error
la $t0, ($v0) # If not. set $t0 to number

# Storing a value for the space needed in the array
mul $t2, $t0, 4

## Getting Array input

# Prompting user to enter x numbers
la $a0, prmpt2
li $v0, 4
syscall
li $v0, 1
la $a0, ($t0)
syscall
li $v0, 4
la $a0, prmpt3
syscall

# Gather input for array

loop: beq $t3, $t2, readInt
li $v0, 5
syscall
sw $v0, array($t3)
add $t3, $t3, 4
j loop

# Read an int from user
readInt: la $a0, prmpt4
li $v0, 4
syscall
li $v0, 5
syscall

# if -1 was entered quit
addi $a0, $zero, -1
beq $v0, $a0, exit

# if not, setup loop
la $t6, array
add $t5, $t6, $t2
li $t7, 0

loop2: beq $t6, $t5, printNum # If to end of list print the number of occurances
lw $t8, ($t6)
bne $t8, $v0, dntInc
addi $t7, $t7, 1
dntInc: addi $t6, $t6, 4
j loop2


printNum: # if $t7 == 0 return "Not found" else return $t7
la $a0, ($t7)
beq $a0, 0, notfound
li $v0, 1
syscall
j readInt
notfound: la $a0, notf
li $v0, 4
syscall
j readInt

exit: li $v0, 10
syscall
