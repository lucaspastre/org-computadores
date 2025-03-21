.data
	h:.word 0
	w:.word 0
	resultado:.word 0
	
.text

main:
	#input pro valor de h
	li $v0, 5
	syscall
	sw $v0, h
	#input pro valor de w
	li $v0, 5
	syscall
	sw $v0, w
	
	#carrega h e w como registradores temporários
	lw $a0, h
	lw $a1, w
	
	#salta para o procedimento
	jal area
	
	#armazena o resultado e encerra o programa
	sw $v0, resultado
	lw $t0, resultado
		
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall

area:
	#multiplica para obter a area
	mul $v0, $a0, $a1
	jr $ra	#retorna para o chamador
	