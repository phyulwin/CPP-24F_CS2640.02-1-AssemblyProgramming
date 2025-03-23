#Write a program in MIPS that prints a string to the user 5 times, then exits the program. 
.data
    message: .asciiz "Hello, MIPS user!\n"  # String to print

.text
.globl main

# Macro for printing a string
.macro printing
    li $v0, 4              # Syscall for print string
    la $a0, message        # Load address of message
    syscall
.end_macro

# Macro for exiting the program
.macro exit
    li $v0, 10             # Syscall for exit
    syscall
.end_macro

main:
    li $t0, 5              # Initialize loop counter to 5

loop:
    printing               # Call macro to print the message
    sub $t0, $t0, 1        # Decrement counter
    bgtz $t0, loop         # If counter > 0, repeat loop

    exit                   # Call macro to exit the program
