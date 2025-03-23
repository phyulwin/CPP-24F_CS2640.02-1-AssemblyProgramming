# CS 2640
# 10/18/2024
# first test code [from slides]

.data
message: .asciiz "this is a message"

.text
main:
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 10
	syscall