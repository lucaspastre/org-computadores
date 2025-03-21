.data
	a:.word 0
	b:.word 0
	msga: .asciiz "Valor de a: "
	msgb: .asciiz "Valor de b: "
	
.text	
	li $v0, 4
	la $a0, msga
	syscall
	li $v0, 5
	syscall
	sw $v0, a
	
	li $v0, 4
	la $a0, msgb
	syscall
	li $v0, 5
	syscall
	sw $v0, b
	
	lw $s0, a
	lw $s1, b

	bgt $s0, $s1, maior
	j end
	
maior:
	addi $s2, $s0, 1
	sw $s2, a
	li $v0, 1
	move $a0, $s2
	syscall

end:
	li $v0, 10
	syscall
	
	