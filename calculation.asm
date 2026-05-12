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
    addi $sp, $sp, -12
    sw $a0, 0($sp) # save $a0 on the stack
    sw $a1, 4($sp)  # save $a1 on the stack
    sw $ra, 8($sp)  # save $ra on stack
    li $t0, 5 # $t0 = z = 5
    move $t1, $a0 # $t1 = x = 4
    move $t2, $a1 # $t2 = y = 10
    move $t3, $a2 # $t3 = n = 3
    li $t4, 0 # $t4 = i = 0
loop:
    bge $t4, $t3, loop_end # if i >= n, end loop
    sub $t0, $t0, $t1
    sll $t5, $t2, 1
    add $t0, $t0, $t5 # $t0 = z = z - x + 2*y
    li $t6, 2
    blt $t1, $t6, no_remove # if x < 2 then no remove
    move $a0, $t1
    move $a1, $t2
    jal remove
no_remove:
    addi $t1, $t1, 1 # x++
    addi $t4, $t4, 1
    j loop
loop_end:
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    move $v0, $t0
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
