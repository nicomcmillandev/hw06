# calculation.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a-registers
#   make all returned values from functions go in $v0

.text
remove:
    # CODE MISSING: Student to complete this part
    sub $v0, $a1, $a0
    jr $ra

calc:
    # CODE MISSING: Student to complete this part
    addi $sp, $sp, -24
    sw $ra, 20($sp)
    sw $s0, 16($sp)
    sw $s1, 12($sp)
    sw $s2, 8($sp)
    sw $s3, 4($sp)
    sw $s4, 0($sp)
    li $s0, 5 # $s0 = z = 5
    move $s1, $a0 # $s1 = x = 4
    move $s2, $a1 # $s2 = y = 10
    move $s3, $a2 # $s3 = n = 3
    li $s4, 0 # $s4 = i = 0
loop:
    bge $s4, $s3, loop_end # if i >= n, end loop
    sub $s0, $s0, $s1
    sll $t5, $s2, 1
    add $s0, $s0, $t5 # $s0 = z = z - x + 2*y
    li $t6, 2
    blt $s1, $t6, no_remove # if x < 2 then no remove
    move $a0, $s1
    move $a1, $s2
    jal remove
    move $s2, $v0
no_remove:
    addi $s1, $s1, 1 # x++
    addi $s4, $s4, 1
    j loop
loop_end:
    move $v0, $s0
    lw $s4, 0($sp)
    lw $s3, 4($sp)
    lw $s2, 8($sp)
    lw $s1, 12($sp)
    lw $s0, 16($sp)
    lw $ra, 20($sp)
    addi $sp, $sp, 24
    jr $ra
    
main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 4
    li $a1, 10
    li $a2, 3

    jal calc

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
