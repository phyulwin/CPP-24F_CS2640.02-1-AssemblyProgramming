# 11-13-24
# Michael Wu
# CS2640
# File Handling
# given 'gradedItems.txt'
# open file
# read 'gradedItems.txt'
# 	print file contents to user in Run I/O tab
# copy the contents and write to a new file
# 	i.e. 'cs2640items.txt' but same content as 'gradedItems.txt'
# close the file

.include "myMacros.asm"

.data
filename: .asciiz "gradedItems.txt"
newFileName: .asciiz "cs2640Items.txt"
buffer: .space 200
fileSuccess: .asciiz "file opened!"

.text
main:
	li $v0, 13 # open file
	la $a0, filename # load file 
	li $a1, 0 # what does this line do
	li $a2, 0 # what does this line do
	syscall
	move $s0, $v0
	
	blt $s0, $zero, closeExit
	
	# print file success msg
	li $v0, 4
	la $a0, fileSuccess
	syscall
	
	# read from file
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 200
	syscall
	
	# open new file (copy of gradedItems.txt)
	li $v0, 13
	la $a0, newFileName
	li $a1, 1
	li $a2, 0
	syscall
	move $s1, $v0
	
	# write to newFileName.txt (paste copied gradedItems.txt)
	li $v0, 15
	move $a0, $s1
	la $a1, buffer
	li $a2, 200
	syscall
	
closeExit:
	
	# close gradedItems.txt
	#li $v0, 16
	#move $a0, $s0
	#syscall
	
	# close newFile.txt
	#li $v0, 16
	#move $a0, $s1
	#syscall
	
	closeFile($s0)
	closeFile($s1)
	
	li $v0, 10
	syscall
	
