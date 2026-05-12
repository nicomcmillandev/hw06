# swap_case.asm program
# For CMPSC 64
#
# Data Area
.data
    buffer:         .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:  .asciiz "Output:\n"
    convention:     .asciiz "Convention Check\n"
    newline:        .asciiz "\n"

.text

#
# DO NOT MODIFY THE MAIN PROGRAM 
#       OR ANY OF THE CODE BELOW, WITH 1 EXCEPTION!!!
# YOU SHOULD ONLY MODIFY THE SwapCase FUNCTION 
#       AT THE BOTTOM OF THIS CODE
#
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    li $s1, 0
    li $s2, 0
    li $s3, 0
    li $s4, 0
    li $s5, 0
    li $s6, 0
    li $s7, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $zero, -1
    addi    $t1, $zero, -1
    addi    $t2, $zero, -1
    addi    $t3, $zero, -1
    addi    $t4, $zero, -1
    addi    $t5, $zero, -1
    addi    $t6, $zero, -1
    addi    $t7, $zero, -1
    ori     $v0, $zero, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    li $v0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #Save everything on the stack
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, 0($sp)
    
    # $s0 will iterate through each character
    move $s0, $a0
    
loop:
    lb $t0, 0($s0)                  # Load current byte
    beq $t0, $zero, loop_end    # Exit loop on null terminator
    
    # Check if character is an uppercase letter 
    li $t1, 65                      
    blt $t0, $t1, SwapCase_Skip
    li $t1, 90                      
    ble $t0, $t1, SwapCase_IsLetter
    
    # Check if character is a lowercase letter 
    li $t1, 97                      
    blt $t0, $t1, SwapCase_Skip
    li $t1, 122                     
    bgt $t0, $t1, SwapCase_Skip
    
SwapCase_IsLetter:
    # Bitwise XOR with 32 flips the 6th bit, swapping ASCII case
    xori $t1, $t0, 32               
    
    # Store the swapped character back to the string in memory
    sb $t1, 0($s0)
    
    # Print the original character ($t0)
    move $a0, $t0
    li $v0, 11                      
    syscall
    
    la $a0, newline                     
    li $v0, 4
    syscall
    
    # Print the new swapped character ($t1)
    move $a0, $t1
    li $v0, 11
    syscall
    
    la $a0, newline
    li $v0, 4
    syscall
    
    jal ConventionCheck
    
SwapCase_Skip:
    addi $s0, $s0, 1                # Increment string pointer by 1 byte
    j loop
    
loop_end:
    # Epilogue: restore preserved registers and deallocate stack
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    
    jr $ra
