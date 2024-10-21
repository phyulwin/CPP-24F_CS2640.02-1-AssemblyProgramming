# CS 2640 - Kelly Lwin
# 10/21/2024
# Assignment Instruction: 
# Write a program in Assembly that takes two number inputs from a user. Have the user select from an output
# menu of the 4 arithmetic options. Display the result in the output to the user. Now, add to your 
# Assembly program error handling and re-prompt the user, and a way for the user to change their numbers, 
# run a new operation, exit the program if they are finished.

# Goals of the program: 
# 1. get input from user
# 2. allow user to choose desired arithmetic operation
# 3. change the numbers if needed
# 4. check for invalid input and division by zero error
# 5. output the result and exit the program

.data
prompt1: .asciiz "Enter the first number: "
prompt2: .asciiz "Enter the second number: "
menu: .asciiz "Choose an operation:\n1. Addition\n2. Subtraction\n3. Multiplication\n4. Division\n5. Change Numbers\n6. Exit\n"
result: .asciiz "The result is: "
error: .asciiz "Invalid option. Try again.\n"
div_zero_error: .asciiz "Error: Division by zero. Try again.\n"

.text
main:
    #prompt the user to input numbers first
    jal input_numbers

#the method will ask the user to choose an opeartion, input new numbers, and exit the program
menu_loop:
    #print out the prompt for menu
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    beq $t2, 1, addition
    beq $t2, 2, subtraction
    beq $t2, 3, multiplication
    beq $t2, 4, division
    beq $t2, 5, input_numbers
    beq $t2, 6, exit
    j invalid_choice # invalid choice if user enters wrong input

#four methods to perform the arithmetic operations
addition:
    add $t3, $t0, $t1
    j print_result

subtraction:
    sub $t3, $t0, $t1
    j print_result

multiplication:
    mul $t3, $t0, $t1
    j print_result

division:
    beq $t1, $zero, div_error
    div $t0, $t1
    mflo $t3
    j print_result

#check for cases where division by zero error occurs
div_error:
    li $v0, 4
    la $a0, div_zero_error
    syscall
    j menu_loop

#check the case where user chooses invalid option
invalid_choice:
    li $v0, 4
    la $a0, error
    syscall
    j menu_loop

#print out prompt1 and prompt2 and store the input values
input_numbers:
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, prompt2
    syscall

    #call the menu to let user choose options
    li $v0, 5
    syscall
    move $t1, $v0
    j menu_loop

#print out the result and let user choose options again
print_result:
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t3
    syscall
    j menu_loop

#exit the program
exit:
    li $v0, 10
    syscall