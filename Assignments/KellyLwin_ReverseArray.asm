.data                   # Data segment
array: .word 5, 4, 3, 2, 1   # Define the array
size:  .word 5              # Define the size of the array
msg1:  .asciiz "Array elements are: "
msg2:  .asciiz "New array is: "
newline: .asciiz " "

.text                   # Code segment
.globl main

main:
    # Load the base address of the array and size
    la $t0, array         # $t0 = base address of the array
    lw $t1, size          # $t1 = size of the array (number of elements)

    # Print original array
    li $v0, 4             # Syscall for printing a string
    la $a0, msg1
    syscall

    jal print_array        # Call print_array subroutine
    li $v0, 4
    la $a0, newline
    syscall

    # Reverse the array
    la $t2, array         # $t2 points to the array start
    add $t3, $t0, $t1     # $t3 points to the end of the array
    sub $t3, $t3, 4       # Subtract 4 bytes (end is one element back)

reverse_loop:
    bge $t2, $t3, done_reversing  # Exit when pointers cross or are equal
    lw $t4, 0($t2)        # Load element at start into $t4
    lw $t5, 0($t3)        # Load element at end into $t5
    sw $t5, 0($t2)        # Store $t5 at start
    sw $t4, 0($t3)        # Store $t4 at end
    addi $t2, $t2, 4      # Move start pointer to the next element
    subi $t3, $t3, 4      # Move end pointer to the previous element
    j reverse_loop

done_reversing:

    # Print reversed array
    li $v0, 4
    la $a0, msg2
    syscall

    jal print_array
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10            # Syscall for exit
    syscall

# Subroutine to print array elements
print_array:
    la $t0, array         # Reload array base address
    lw $t1, size          # Reload array size
    move $t6, $t1         # Copy size into $t6

print_loop:
    beqz $t6, print_done  # Exit when all elements are printed
    lw $a0, 0($t0)        # Load current element into $a0
    li $v0, 1             # Syscall for printing integer
    syscall

    # Print a space
    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 4      # Move to the next element
    subi $t6, $t6, 1      # Decrement element count
    j print_loop

print_done:
    jr $ra                # Return to the caller
