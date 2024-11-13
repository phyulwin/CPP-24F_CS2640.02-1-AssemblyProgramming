# CS 2640 - Kelly Lwin
# 10/28/2024
# Program 2: Practice with Conditionals and Loops

# Task 1: Return a Letter Grade from User Input

.data
newline: .asciiz "\n"
menu: .asciiz "MAIN MENU\n(1) Get Letter Grade\n(2) Exit Program\n\nEnter '1' or '2' for your selection: "
score_prompt: .asciiz "Please enter a score as an integer value: "
exit_prompt: .asciiz "The program will now exit."

retry_prompt_msg: .asciiz "Would you like to enter a new score?\n(Y)Yes (N)No\n\nEnter 'Y' or 'N' for your selection: "
invalid_input: .asciiz "Invalid input, please enter a grade between 0 and 100.\n"
invalid_selection: .asciiz "Invalid selection, please choose '1' or '2'.\n"
non_integer_input: .asciiz "Invalid input, please enter a valid integer.\n"

grade_a: .asciiz "The grade is: A\n"
grade_b: .asciiz "The grade is: B\n"
grade_c: .asciiz "The grade is: C\n"
grade_d: .asciiz "The grade is: D\n"
grade_f: .asciiz "The grade is: F\n"

.text
.globl main

main:
    j display_menu                           # Start by displaying the main menu

display_menu:
    li $v0, 4
    la $a0, menu                             # Display main menu options
    syscall

    li $v0, 5                                # Read user selection (1 or 2)
    syscall

    # Ensure selection is either 1 or 2
    move $t0, $v0                            # Store selection in $t0
    beq $t0, 1, get_grade                    # If user selects 1, go to get_grade
    beq $t0, 2, exit_program                 # If user selects 2, go to exit
    j handle_invalid_selection

get_grade:
    # Prompt user to enter a grade
    li $v0, 4
    la $a0, score_prompt
    syscall

read_grade:
    li $v0, 5                                # Read the grade input as an integer
    syscall
    bltz $v0, non_integer_error              # Check if the input is not a valid integer
    move $t1, $v0                            # Store grade in $t1

    # Input validation: check if grade is in range 0-100
    blt $t1, 0, invalid_grade                # If input < 0, go to invalid_grade
    bgt $t1, 100, invalid_grade              # If input > 100, go to invalid_grade

    # Determine the letter grade based on the range
    bge $t1, 90, print_a                     # If grade >= 90, it's an A
    bge $t1, 80, print_b                     # If grade >= 80, it's a B
    bge $t1, 70, print_c                     # If grade >= 70, it's a C
    bge $t1, 60, print_d                     # If grade >= 60, it's a D
    j print_f                                # Otherwise, it's an F

# Print letter grade sections
print_a:
    li $v0, 4
    la $a0, grade_a
    syscall
    j retry_prompt

print_b:
    li $v0, 4
    la $a0, grade_b
    syscall
    j retry_prompt

print_c:
    li $v0, 4
    la $a0, grade_c
    syscall
    j retry_prompt

print_d:
    li $v0, 4
    la $a0, grade_d
    syscall
    j retry_prompt

print_f:
    li $v0, 4
    la $a0, grade_f
    syscall
    j retry_prompt

# Handle invalid input
invalid_grade:
    li $v0, 4
    la $a0, invalid_input                   # Print invalid input message
    syscall
    j get_grade                             # Re-prompt the user for grade input

# Handle non-integer input error
non_integer_error:
    li $v0, 4
    la $a0, non_integer_input               # Print non-integer input message
    syscall
    j get_grade                             # Re-prompt the user for grade input

# Handle invalid selection in main menu
handle_invalid_selection:
    li $v0, 4
    la $a0, invalid_selection               # Print invalid selection message
    syscall
    j display_menu                          # Re-display menu

# Prompt user to continue or return to menu
retry_prompt:
    li $v0, 4
    la $a0, retry_prompt_msg                 # Prompt to enter a new score or exit
    syscall

    li $v0, 12                               # Read a single character for 'Y' or 'N'
    syscall
    beq $v0, 'Y', get_grade                  # If 'Y', prompt for a new grade
    beq $v0, 'y', get_grade                  # Also handle lowercase 'y'
    beq $v0, 'N', display_menu               # If 'N', go back to main menu
    beq $v0, 'n', display_menu               # Also handle lowercase 'n'
    
    # Invalid input, re-display retry prompt
    j retry_prompt            

# Exit program
exit_program:
    li $v0, 4
    la $a0, exit_prompt
    syscall
    li $v0, 10                              # Exit program syscall
    syscall
