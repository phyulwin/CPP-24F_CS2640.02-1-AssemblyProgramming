# CS 2640 - Kelly Lwin
# 11/23/2024
# Program 3: Accessing Memory and File Handling

# Assignment Instruction: 
# Write a program in Assembly that takes creates a file and writes to it.
# The program uses macros, handles errors, and includes a simple menu

.data
menu: .asciiz "Menu:\n1. Create a new file and write to it\n2. Exit\nChoose an option: "
prompt_filename: .asciiz "Enter the filename: "
prompt_content: .asciiz "Enter content to write to the file: "
fileError: .asciiz "Error: Unable to create or open the file.\n"
successMessage: .asciiz "File created and content written successfully!\n"
exitMessage: .asciiz "Exiting the program.\n"
buffer: .space 200

.text
main:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $t1, 1
    beq $t0, $t1, create_file

    li $v0, 4
    la $a0, exitMessage
    syscall
    li $v0, 10
    syscall

create_file:
    li $v0, 4
    la $a0, prompt_filename
    syscall

    li $v0, 8
    la $a0, buffer
    li $a1, 200
    syscall

    li $v0, 13
    la $a0, buffer
    li $a1, 1
    li $a2, 0
    syscall
    move $s0, $v0

    blt $s0, $zero, file_open_error

    li $v0, 4
    la $a0, prompt_content
    syscall

    li $v0, 8
    la $a0, buffer
    li $a1, 200
    syscall

    li $v0, 15
    move $a0, $s0
    la $a1, buffer
    li $a2, 200
    syscall

    li $v0, 4
    la $a0, successMessage
    syscall

    li $v0, 16
    move $a0, $s0
    syscall

    li $v0, 10
    syscall

file_open_error:
    li $v0, 4
    la $a0, fileError
    syscall
    li $v0, 10
    syscall
