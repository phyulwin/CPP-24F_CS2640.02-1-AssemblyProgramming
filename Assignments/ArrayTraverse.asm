# CS 2640 - Kelly Lwin
# 10/21/2024
# Assignment Instruction: 
# Given the following array, traverse and print out the array
# elements to the user. array = [1, 2, 3, 4, 5]

# Goals of the program: 
# 1. initialize message, array and load data
# 2. add elements in array by order
# 3. print out the result of operations

.data
array: .word 1, 2, 3, 4, 5
message: .asciiz "The array elements are:\n"

.text
main:
    li $v0, 4
    la $a0, message
    syscall
	
    #load base address of the array into $s0
    la $s0, array  
    #set loop counter for 5 elements
    li $t1, 5          

loop:
    #load current element into $t0
    lw $t0, 0($s0)     
    li $v0, 1
    move $a0, $t0
    syscall

    #move to the next element in the array
    addi $s0, $s0, 4
    #decrement loop counter   
    subi $t1, $t1, 1 
    #continue looping if counter > 0 
    bgtz $t1, loop     

#exit the program
exit:
    li $v0, 10         
    syscall