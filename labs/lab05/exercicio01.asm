.data
	numero:.word 0
	msg:.asciiz "Digite um valor para n: "
	msgR:.asciiz "Fatorial de n: "

.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall
	sw $v0, numero
	
	li $s0, 1
	lw $s1, numero
	li $s2, 1
	
	beq $s1, $zero, fim
	
	loop:
		beq $s1, $s0, fim
		mul $s2, $s2, $s1
		subi $s1, $s1, 1
		j loop

	fim:
		li $v0, 4
		la $a0, msgR
		syscall
		
		li $v0, 1
		move $a0, $s2
		syscall
		
		li $v0, 10
		syscall
	
