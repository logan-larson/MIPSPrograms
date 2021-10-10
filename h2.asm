# Logan Larson

.data
prmpt: .asciiz "Which fibonacci number do you want? "
notPos: .asciiz "You must enter an integer greater than or equal to zero. Try again. "
fibNum: .asciiz "The fibinacci number is "

.text

la $a0, prmpt
jal readNonNegInt

la $a0, ($v0)
jal fib

la $a0, fibNum
la $a1, ($v0)
jal printInt

li $v0, 10
syscall

readInt: li $v0, 4 # $a0 contains the prompt
syscall
li $v0, 5
syscall
jr $ra

readNonNegInt: sw $ra, ($sp) # Stores return address in stack because it calls a helper function
jal readInt
bgez $v0, return # If input is > 0 exit otherwise ask again
la $a0, notPos
j readInt
return: lw $ra, ($sp) # Get original ra and return
jr $ra

printInt: li $v0, 4
syscall
la $a0, ($a1)
li $v0, 1
syscall
jr $ra

fib: bgt $a0, 1, fibHelp # Check base case
add $v0, $a0, $zero # Base Case: return number
jr $ra

fibHelp: addi $sp, $sp, -12 # Clear room in stack to store the return address, value, and return value
sw $ra, ($sp)
sw $a0, 4($sp)
addi $a0, $a0, -1 # Call fib(n-1)
jal fib
sw $v0, 8($sp) # Store the value returned from fib(n-1)
lw $a0, 4($sp) # Load the original value and decrease it by 2
addi $a0, $a0, -2 # Call fib(n-2)
jal fib
lw $t0, 8($sp) # Retrieve the value and add it to the total fibonacci number
add $v0, $v0, $t0
lw $ra, 0($sp) # Jump to previous ra
addi $sp, $sp, 12 # and decrease sp value to grab from one 
jr $ra
