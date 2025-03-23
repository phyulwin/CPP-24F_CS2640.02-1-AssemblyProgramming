# CS 2640 - Kelly Lwin
# 10/21/2024
# Assignment Instruction: 
# Write a program in Assembly that takes two numbers from a user and outputs the greater number.

# Goals of the program: 
# 1) prompt user for input
# 2) get input
# 3) print out greater number 

.data
prompt1: .asciiz "Enter the first number: "
prompt2: .asciiz "Enter the second number: "
result:  .asciiz "The greater number is: "

.text
main:
	#printing prompt 1
	li $v0, 4
	la $a0, prompt1
	syscall
	
	#get the first input
	li $v0, 5
	syscall
	move $t0, $v0  # store the first number in $t0

	#printing prompt 2
	li $v0, 4
	la $a0, prompt2
	syscall

	#get the second input
	li $v0, 5
	syscall
	move $t1, $v0  # store the second number in $t1

	#compare the two numbers
	blt $t0, $t1, second_is_greater  # if $t0 < $t1, jump to second_is_greater

first_is_greater:
	#print the result (first number is greater)
	li $v0, 4
	la $a0, result
	syscall

	li $v0, 1
	move $a0, $t0
	syscall
	j exit

second_is_greater:
	#print the result (second number is greater)
	li $v0, 4
	la $a0, result
	syscall

	li $v0, 1
	move $a0, $t1
	syscall

exit:
	#exit the program
	li $v0, 10
	syscall