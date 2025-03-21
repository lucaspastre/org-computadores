.data
	base:.word 0
	expoente:.word 0
	resultado:.word 0

.text

main:
	#input para o valor da base
	li $v0, 5
	syscall
	sw $v0, base
	#input para o valor do expoente
	li $v0, 5
	syscall
	sw $v0, expoente
	
	#carrega base e expoente como argumentos
	lw $a0, base
	lw $a1, expoente
	
	#chama o procedimento
	jal pow
	
	#armazena o resultado
	sw $v0, resultado
	lw $s1, resultado
	
	#printa na tela
	li $v0, 1
	move $a0, $s1
	syscall
	
	#encerra o programa
	li $v0, 10
	syscall
	
pow:	
	#contador para o loop
	move $s0, $zero
	#inicializando $v0 como 1 pois qualquer numero elevado a 0 é 1
	li $v0, 1
loop:
	beq $s0, $a1, end
	mul $v0, $v0, $a0
	addi $s0, $s0, 1
	j loop

end:
	jr $ra
	
	
	