# Input three numbers
# Compute the summation
# Print the summation
.data
prompt: .asciiz "Enter a number:\n"
.text
# Input three numbers
jal readNum # Will return a value in $v0
la $t1, ($v0)
jal readNum
la $t2, ($v0)
jal readNum
la $t3, ($v0) # Ints are in $t1,2,3
# Compute the summation
add $t1, $t1, $t2
add $t1, $t1, $t3 # Added ints into $t1
# Print the summation
la $a0, ($t1)
li $v0, 1
syscall
# End program
li $v0, 10
syscall
readNum: la $a0, prompt
li $v0, 4
syscall
li $v0, 5
syscall
jr $ra
