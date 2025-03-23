# CS 2640 - Kelly Lwin
# 10/28/2024
# Program 2: Practice with Conditionals and Loops

# Task 2: Advanced Math - x to the power of y
# This program calculates x to the power of y using a loop counter to multiply x by itself y times.

.data
intro_msg: .asciiz "This program asks the user to input a value for 'x' and 'y'.\nThen, it finds the value of x to the power y.\nFor example, 2 to the power 3 is 8.\n\n"
x_prompt: .asciiz "Enter a number for 'x': "
y_prompt: .asciiz "Enter a number for 'y': "
result_msg: .asciiz "'x' to the power 'y' is: "

newline: .asciiz "\n"
exit_msg: .asciiz "The program will now exit.\n"

.text
.globl main

main:
    # Display introductory message
    li $v0, 4
    la $a0, intro_msg
    syscall

    # Prompt for x
    li $v0, 4
    la $a0, x_prompt
    syscall

    # Read integer x
    li $v0, 5
    syscall
    move $t0, $v0

    # Prompt for y
    li $v0, 4
    la $a0, y_prompt
    syscall

    # Read integer y
    li $v0, 5
    syscall
    move $t1, $v0

    # Initialize result to 1 (x^0 = 1)
    li $t2, 1              

    # Set loop counter to y
    move $t3, $t1          

power_loop:
    # Check if loop counter (y) is 0
    # If y <= 0, skip loop and display result
    blez $t3, display_result  

    # Multiply result by x (result *= x)
    mul $t2, $t2, $t0

    # Decrement loop counter
    sub $t3, $t3, 1

    # Loop until counter reaches 0
    j power_loop

display_result:
    # Display result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Display calculated result
    li $v0, 1
    move $a0, $t2
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

exit_program:
    # Display exit message
    li $v0, 4
    la $a0, exit_msg
    syscall

    # Exit the program
    li $v0, 10
    syscall