# CS 2640 - Kelly Lwin
# 11/23/2024
# Program 3: Accessing Memory and File Handling

# Assignment Instruction: 
# Given an array of test scores, traverse the array and determine the letter grade 
# for each score. Handle cases for grades above 100 as "A with Extra Credit."

# Goals of the program: 
# Initialize messages, array, and load data
# Determine letter grades for each score in the array
# Print the results and exit the program

.data
scores: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82
num_scores: .word 10
grade_message: .asciiz "The grade for "
f_grade: .asciiz " is: F\n"
d_grade: .asciiz " is: D\n"
c_grade: .asciiz " is: C\n"
b_grade: .asciiz " is: B\n"
a_grade: .asciiz " is: A\n"
extra_credit_message: .asciiz " is: A with Extra Credit\n"
exit_message: .asciiz "The program will now exit.\n"

.text
main:
    # Initialize array pointer and loop counter
    la $s0, scores        # Load base address of the array into $s0
    lw $t1, num_scores    # Load the number of scores into $t1 (loop counter)

loop:
    # Check if loop counter is zero, exit if it is
    blez $t1, end_loop

    # Load current score from the array
    lw $t0, 0($s0)

    # Print "The grade for "
    li $v0, 4
    la $a0, grade_message
    syscall

    # Print the current score
    li $v0, 1
    move $a0, $t0
    syscall

    # Determine and print the grade
    bgt $t0, 100, print_extra   # If score > 100, handle extra credit
    bge $t0, 90, print_a        # If score >= 90, print A
    bge $t0, 80, print_b        # If score >= 80, print B
    bge $t0, 70, print_c        # If score >= 70, print C
    bge $t0, 60, print_d        # If score >= 60, print D
    j print_f                   # Otherwise, print F

print_f:
    li $v0, 4
    la $a0, f_grade
    syscall
    j next

print_d:
    li $v0, 4
    la $a0, d_grade
    syscall
    j next

print_c:
    li $v0, 4
    la $a0, c_grade
    syscall
    j next

print_b:
    li $v0, 4
    la $a0, b_grade
    syscall
    j next

print_a:
    li $v0, 4
    la $a0, a_grade
    syscall
    j next

print_extra:
    li $v0, 4
    la $a0, extra_credit_message
    syscall

next:
    # Move to the next element in the array
    addi $s0, $s0, 4

    # Decrement loop counter and repeat
    subi $t1, $t1, 1
    j loop

end_loop:
    # Print exit message
    li $v0, 4
    la $a0, exit_message
    syscall

    # Exit the program
    li $v0, 10
    syscall
