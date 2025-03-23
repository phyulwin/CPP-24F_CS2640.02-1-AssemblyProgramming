# CS 2640 - Kelly Lwin
# 10/21/2024
# Assignment Instruction: 
# Given the following array, add the values separately and then all
# three together. Output the values one at a time and display the
# user of the operation details. array = [3, 4, 5]

# Goals of the program: 
# 1. initialize array and load data
# 2. add elements in array by order
# 3. print out the result of operations

.data
# initialize array data
array: .word 3, 4, 5
# print out result of additions
msg1: .asciiz "3 + 4 = "
msg2: .asciiz "3 + 5 = "
msg3: .asciiz "4 + 5 = "
msg4: .asciiz "3 + 4 + 5 = "
# add newline character for results
newline: .asciiz "\n"

.text
main:
    la $t0, array          # load base address of the array into $t0
    lw $t1, 0($t0)         # load array[0] (3) into $t1
    lw $t2, 4($t0)         # load array[1] (4) into $t2
    lw $t3, 8($t0)         # load array[2] (5) into $t3

    #perform t4 = 3 + 4 and print message
    add $t4, $t1, $t2     
    li $v0, 4
    la $a0, msg1
    syscall  
    #print result of 3 + 4              
    li $v0, 1
    move $a0, $t4
    syscall 
    jal print_newline              

    #perform t5 = 3 + 5 and print message
    add $t5, $t1, $t3     
    li $v0, 4
    la $a0, msg2
    syscall  
    #print result of 3 + 5             
    li $v0, 1
    move $a0, $t5
    syscall   
    jal print_newline            

    #performs t6 = 4 + 5 and print message
    add $t6, $t2, $t3   
    li $v0, 4
    la $a0, msg3
    syscall               
    #print result of 4 + 5
    li $v0, 1
    move $a0, $t6
    syscall  
    jal print_newline              

    #performs t7 = 3 + 4 + 5 and print message
    add $t7, $t4, $t3      
    li $v0, 4
    la $a0, msg4
    syscall 
    #print result of 3 + 4 + 5               
    li $v0, 1
    move $a0, $t7
    syscall 
    jal print_newline              
    
    #exit the program
    li $v0, 10         
    syscall

print_newline:
    li $v0, 4
    la $a0, newline
    syscall
    #return to the caller            
    jr $ra       
    
# program output: 
# 3 + 4 = 7
# 3 + 5 = 8
# 4 + 5 = 9
# 3 + 4 + 5 = 12