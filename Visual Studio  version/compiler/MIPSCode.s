.globl main

.data
temp: .space 44

.text
__printf_one:
li $v0, 1
syscall
jr $ra
__scanf_one:
li $v0,5
syscall
jr $ra

main:
la $a3, temp
add $8, $29, -40
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -12($sp)
jal __scanf_one
lw $9, -12($sp)
sw $2, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -16($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 10
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
add $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
move $4, $9
jal __printf_one
li $8, 0
sw $8, -36($sp)
add $8, $29, 4
sw $8, -32($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
j __program_end
j __program_end
__program_end:
li $v0, 10
syscall
