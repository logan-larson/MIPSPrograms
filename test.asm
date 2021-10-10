.data
array: .word 1,2,3,4,5

.text
la $t6, array
addi $t6, $t6, 20 # $t6 is end of array position
lbl2: li $v0, 5 
syscall
sw $v0, 0($a0)
addi $a0, $a0, 4
slt $t7, $a0, $t6
bne $zero, $t7, lbl2
