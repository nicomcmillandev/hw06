# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1
#   make all returned values from functions go in $v0

# Example array and alen - your code should work for any integer array of any length > 1.
.data
    array:  .word 6, 4, 0, 1, 2, 9, 3, 5, 8, 7
    alen:   .word 10
    newline: .asciiz "\n"
    space:  .asciiz " "

.text
bubble:
	# CODE MISSING: Student to complete this part    
    lw $t1, 0($a1)         # Load the value of length from the address in $a1
    move $t0, $a0          # Store base address of array in $t0
    addi $t2, $t1, -1      # $t2 i = size - 1

loop_i:
    blt $t2, $zero, loop_i_end    # If i < 0, end outer loop
    li $t3, 1              # $t3 j = 1

loop_j:
    bgt $t3, $t2, loop_j_end # If j > i, end inner loop
    
    sll $t6, $t3, 2        # $t6 = j * 4 
    add $t6, $t6, $t0      # $t6 = base address + j * 4
    
    lw $t8, 0($t6)         # $t8 = array[j]
    lw $t7, -4($t6)        # $t7 = array[j-1] 
  
    ble $t7, $t8, no_swap  # If array[j-1] <= array[j], do not swap

    sw $t8, -4($t6)        # array[j-1] = array[j]
    sw $t7, 0($t6)         # array[j] = temp (original array[j-1])

no_swap:
    addi $t3, $t3, 1       # j++
    j loop_j

loop_j_end:
    addi $t2, $t2, -1      # i--
    j loop_i

loop_i_end:
    jr $ra                 

printArray:
	# CODE MISSING: Student to complete this part
    li $t0, 0 # $t0 = i = 0
    move $t1, $a0 # $t1 = base address
    lw $t2, 0($a1) # $t2 = size
    loop:
    bge $t0, $t2, loop_end # If i >= size, end loop
    sll $t3, $t0, 2  # i * 4
    add $t3, $t3, $t1 # base address + t * 4
    lw $a0, 0($t3)
    li $v0, 1 
    syscall # print array[i]
    la $a0, space
    li $v0, 4
    syscall
    addi $t0, $t0, 1 # i++
    j loop

loop_end:
    li $v0, 4
    la $a0, newline
    syscall
    jr $ra 

main:
    la $a0, array
    la $a1, alen
    jal printArray

    la $a0, array
    la $a1, alen
    jal bubble

    la $a0, array
    la $a1, alen
    jal printArray

    li $v0, 10
    syscall	