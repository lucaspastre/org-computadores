.data
vetor:
    	.align 2
    	.space 24     # Espaço para 6 palavras (24 bytes)

.text
    	li $s0, 0x10010020   # Carregar o endereço inicial do vetor no registrador $s0
	
	move $t0, $zero	# variavel i
	
	li $t2, 1	# realiza v[i] = 1
	sw $t2, 0($s0)
	
	li $t2, 3		#realiza v[i] = 3
	addi $t0, $t0, 1
	mul $t3, $t0, 4		#multiplica o valor de i por 4 para acessar a posicao correta
	add $t4, $s0, $t3
	sw $t2, 0($t4)
	
	li $t2, 2		#realiza v[i] = 2
	addi $t0, $t0, 1
	mul $t3, $t0, 4
	add $t4, $s0, $t3
	sw $t2, 0($t4)
	
	li $t2, 1
	addi $t0, $t0, 1
	mul $t3, $t0, 4
	add $t4, $s0, $t3
	sw $t2, 0($t4)
	
	li $t2, 4
	addi $t0, $t0, 1
	mul $t3, $t0, 4
	add $t4, $s0, $t3
	sw $t2, 0($t4)
	
	li $t2, 5
	addi $t0, $t0, 1
	mul $t3, $t0, 4
	add $t4, $s0, $t3
	sw $t2, 0($t4)
	
	li $v0, 10           # Finaliza o programa
	syscall
