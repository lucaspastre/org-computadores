.data
	matriz:.space 1024	# aloca espaço para 256 words
	espaco:.asciiz " "
	quebra:.asciiz "\n"
	
.text
	move $s0, $zero
	li $s1, 16
	li $s7, 0     # contador valor
	
	loop_linha:
		beq $s0, $s1, fim
		move $s2, $zero	 # reseta o índice da coluna
	
	loop_coluna:
		li $s3, 16
		beq $s2, $s3, proxima_linha
		
		# calculo do endereço de matriz[linha][coluna]
		# endereço do elemento = endereço base + (linha x num de colunas + coluna) x 4 bytes
		
		mul $s4, $s0, $s3	# linha x num de colunas
		add $s5, $s4, $s2	# (linha x num de colunas) + coluna
		
		#deslocamento de 2 p/ esquerda p/ multiplicar por 4
		sll $s6, $s5, 2		# ((linha x num de colunas) + coluna) x 4
		
		la $t0, matriz   	# carrega endereço base
		add $t1, $t0, $s6	# endereço base + deslocamento
		sw $s7, 0($t1)		# armazena o valor na memória
		
		#li $v0, 1
		#move $a0, $s7
		#syscall
		#li $v0, 4
		#la $a0, espaco
		#syscall
		
		addi $s2, $s2, 1
		addi $s7, $s7, 1
		
		j loop_coluna
		
	proxima_linha:
		li $v0, 4
		la $a0, quebra
		syscall
		
		addi $s0, $s0, 1	
		
		j loop_linha
	
	fim:
		li $v0, 10	# encerra o programa
		syscall



