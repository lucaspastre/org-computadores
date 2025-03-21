.data
	total:.word 0
	msg:.asciiz "Valor da soma: "
	
.text
	
	li $t0, 5
	
soma:
	beq $t0, $zero, end
	add $t1, $t1, $t0
	sub $t0, $t0, 1
	j soma

end:
	sw $t1, total
	
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	