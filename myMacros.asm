.macro closeFile(%reg)
	li $v0, 16
	move $a0, %reg
	syscall
.end_macro