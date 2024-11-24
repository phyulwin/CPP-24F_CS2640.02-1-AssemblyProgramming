# CS 2640 - Kelly Lwin
# 11/23/2024
# Program 3: Accessing Memory and File Handling

# Assignment Instruction: 
# Write a program in Assembly that takes practiceFile.txt file and appends to it.

.data
prompt_filename: .asciiz "Enter the filename to append to: "
prompt_text: .asciiz "What have you enjoyed most about the class so far?\n"
fileError: .asciiz "Error: Unable to open file.\n"
buffer: .space 100

# Goals of the program: 
# Prompt the user for a filename and read input.
# Open the file in append mode.
# Append a message to the file.
# Print a success message.
# Close the file.

.text
main:
    # Prompt user for filename
    li $v0, 4
    la $a0, prompt_filename
    syscall

    # Read user input for filename
    li $v0, 8
    la $a0, buffer 
    li $a1, 100         # Max length of filename
    syscall

    # Open the file in append mode
    li $v0, 13
    la $a0, buffer    
    li $a1, 8           
    li $a2, 0      
    syscall
    move $s0, $v0       # Store file descriptor in $s0

    # Check if the file was opened successfully
    blt $s0, $zero, file_open_error

    # Write the text to the file
    li $v0, 15
    move $a0, $s0       
    la $a1, prompt_text
    li $a2, 100         
    syscall

    # Close the file
    li $v0, 16
    move $a0, $s0      
    syscall

    # Exit the program
    li $v0, 10
    syscall

file_open_error:
    li $v0, 4
    la $a0, fileError
    syscall
    li $v0, 10
    syscall
