.data
nums: .word 4,3,12,7,14,17,6,9,7,5

.text
li $t0, 7
li $t1, 10

la $t3, nums

add $t4, $t1,$t1
add $t4, $t4, $t1
add $t4, $t4, $t1

add $t4, $t3, $t4

loop: beq $t3, $t4, exit
lw $t5, ($t3)
bne $t5, $t0, notEq
addi $t2, $t2, 1
notEq: addi $t3, $t3, 4
j loop

exit: li $v0, 1
add $a0, $t2, $zero
syscall
li $v0, 10
syscall