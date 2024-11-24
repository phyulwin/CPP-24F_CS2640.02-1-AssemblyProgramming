# CS 2640 - Kelly Lwin
# 11/23/2024

# Assignment Instruction:
# Write a program to open, read, and print the contents of practiceFile.txt.

# Goals of the program:
# Open the file.
# Read its contents.
# Print the contents to the console.
# Close the file and exit the program.

.data
filename: .asciiz "practiceFile.txt" 
buffer: .space 1024 
msg_finished: .asciiz "\nThe program will now exit.\n"

.text
main:
    # Open the file
    li $v0, 13   
    la $a0, filename
    li $a1, 0      
    li $a2, 0 
    syscall
    move $s0, $v0              # Save file descriptor in $s0

    # Check if file opened successfully
    bltz $s0, file_error       # If $v0 < 0, handle error

read_file:
    # Read from the file
    li $v0, 14                
    move $a0, $s0             
    la $a1, buffer
    li $a2, 1024 
    syscall
    move $t0, $v0              # Save the number of bytes read in $t0

    # Check if end of file or error
    blez $t0, close_file       # If $t0 <= 0, exit reading

    # Print the contents of the buffer
    li $v0, 4                 
    la $a0, buffer
    syscall

    # Exit and close file
    j close_file

file_error:
    # Print error message if file failed to open
    li $v0, 4
    la $a0, msg_finished 
    syscall
    j exit_program

close_file:
    # Close the file
    li $v0, 16             
    move $a0, $s0     
    syscall

    # Print finished message
    li $v0, 4               
    la $a0, msg_finished
    syscall

exit_program:
    li $v0, 10      
    syscall