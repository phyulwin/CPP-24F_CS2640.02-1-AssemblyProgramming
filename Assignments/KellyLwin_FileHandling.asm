# CS 2640 - Kelly Lwin
# 11/16/2024
# Program 3: File Handling in MIPS - Read Existing, Write New

# given 'gradedItems.txt'
# open and read the file
# print file contents to user in Run I/O tab
# copy the contents of given file to a new file
# close the files

.data
# removed abs path for assignment submission
filename: .asciiz "gradedItems.txt"
newFileName: .asciiz "CS2640Items.txt"

buffer: .space 200

fileOpenSuccess: .asciiz "File opened successfully!\n"
fileReadFail: .asciiz "Failed to read the file.\n"
fileWriteSuccess: .asciiz "File written successfully!\n"
fileWriteFail: .asciiz "Failed to write to the file.\n"

.text
main:
    # Open gradedItems.txt for reading
    li $v0, 13
    la $a0, filename
    li $a1, 0       # Read-only mode
    li $a2, 0
    syscall
    move $s0, $v0   # File descriptor for gradedItems.txt
    blt $s0, $zero, errorRead

    # Print success message
    li $v0, 4
    la $a0, fileOpenSuccess
    syscall

    # Read from gradedItems.txt
    li $v0, 14
    move $a0, $s0
    la $a1, buffer
    li $a2, 200
    syscall
    move $t0, $v0  # Store byte count from read
    blt $t0, $zero, errorRead

    # Null-terminate the buffer
    sb $zero, buffer($t0)

    # Print the file content to the console
    li $v0, 4       # Print string syscall
    la $a0, buffer
    syscall

    # Open CS2640Items.txt for writing
    li $v0, 13
    la $a0, newFileName
    li $a1, 438  # Standard write permissions (rw-rw-r--)
    li $a2, 0
    syscall
    move $s1, $v0
    blt $s1, $zero, errorWrite

    # Write to new file
    li $v0, 15
    move $a0, $s1
    la $a1, buffer
    move $a2, $t0  # Write only the bytes read
    syscall
    blt $v0, $zero, errorWrite

    # Print file write success message
    li $v0, 4
    la $a0, fileWriteSuccess
    syscall
    j closeExit

errorRead:
    # Print file read error message
    li $v0, 4
    la $a0, fileReadFail
    syscall
    j closeExit

errorWrite:
    # Print file write error message
    li $v0, 4
    la $a0, fileWriteFail
    syscall
    j closeExit

closeExit:
    # Close files
    li $v0, 16
    move $a0, $s0
    syscall

    li $v0, 16
    move $a0, $s1
    syscall

    # Exit program
    li $v0, 10
    syscall