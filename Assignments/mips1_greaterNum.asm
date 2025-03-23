# CS 2640
# 10/18/2024
# Program to take two numbers from the user and output the greater number

.data
prompt1: .asciiz "Enter the first number: "
prompt2: .asciiz "Enter the second number: "
outputMsg: .asciiz "The greater number is: "

.text
main:
    # Prompt for the first number
    li $v0, 4               # syscall for print string
    la $a0, prompt1        # load address of prompt1
    syscall

    li $v0, 5               # syscall for read integer
    syscall
    move $t0, $v0           # store the first number in $t0

    # Prompt for the second number
    li $v0, 4               # syscall for print string
    la $a0, prompt2        # load address of prompt2
    syscall

    li $v0, 5               # syscall for read integer
    syscall
    move $t1, $v0           # store the second number in $t1

    # Compare the two numbers
    bgt $t0, $t1, printGreater # if $t0 > $t1, go to printGreater
    move $t0, $t1           # else, move $t1 to $t0 (now $t0 is the greater number)

printGreater:
    # Output the greater number
    li $v0, 4               # syscall for print string
    la $a0, outputMsg      # load address of output message
    syscall

    move $a0, $t0           # move the greater number to $a0 for printing
    li $v0, 1               # syscall for print integer
    syscall

    # Exit the program
    li $v0, 10              # syscall for exit
    syscall
