# CS 2640 - Kelly Lwin
# 10/21/2024
# Assignment Instruction: 
# Write a program in Assembly that takes two number inputs from a user. Have the user select from an output
# menu of the 4 arithmetic options. Display the result in
# the output to the user.

# Goals of the program: 
# 1. get input from user
# 2. allow user to choose desired arithmetic operation
# 3. perform the chosen arithmetic operation
# 4. output the result

.data
prompt1: .asciiz "Enter the first number: "
prompt2: .asciiz "Enter the second number: "
menu: .asciiz "Choose an operation:\n1. Addition\n2. Subtraction\n3. Multiplication\n4. Division\n"
result: .asciiz "The result is: "
error: .asciiz "Invalid option."

.text
main:
    #print out prompt1 and store input in prompt1
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0
    
    #print out prompt2 and store input in prompt2
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0
	
    #print out menu and store input in menu
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t2, $v0
	
    #run cases based on user input
    beq $t2, 1, addition
    beq $t2, 2, subtraction
    beq $t2, 3, multiplication
    beq $t2, 4, division
    j invalid

#do the arithmetic operatin and output result
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
    beq $t1, $zero, invalid
    div $t0, $t1
    mflo $t3
    j print_result

#method to print result
print_result:
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t3
    syscall
    j exit

#check for invalid cases
invalid:
    li $v0, 4
    la $a0, error
    syscall
    j exit

#method to exit the program
exit:
    li $v0, 10
    syscall