.macro exit
    li $v0, 10
    syscall
.end_macro

.macro aString(%strings)
    li $v0, 4 #print instruction
    .data 
    userString:.asciiz %strings
    .text
    la $a0, userString
    syscall
.end_macro 

.macro nextValueArray(%arr1)
	lw $t0, arr1+8 
	addi $t0, $t0, 1
	sw $t0, arr1+12 
.end_macro 


.data
arr1: .word 1, 2, 3 #arr1
userString: .space 11 #buffer of 11 bytes(characters)

.text
main: 
	aString("some words\n")
	nextValueArray(arr1)
	
	#get user input(string)
	li $v0, 8
	la $a0, userString #a0 for the buffer
	li $a1, 15 #a1 for the array length
	syscall 
	
	exit