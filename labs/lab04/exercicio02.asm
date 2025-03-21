.data
	matriz:.space 1024	# aloca espaço para 256 words
	espaco:.asciiz " "
	quebra:.asciiz "\n"

.text
	move $s0, $zero
	li $s1, 16
	li $s7, 0    # contador valor
	
	loop_linha:
		beq $s0, $s1, print
		move $s2, $zero	 # reseta o índice da coluna
	
	loop_coluna:
		li $s3, 16
		beq $s2, $s3, proxima_linha
		
		# calculo do endereço de matriz[linha][coluna]
		
		# endereço do elemento = endereço base + (coluna x num de linhas + linha) x 4 bytes
		
		mul $s4, $s2, $s3	# coluna x num de linhas
		add $s5, $s4, $s0	# (coluna x num de linhas) + linha
		
		#deslocamento de 2 p/ esquerda p/ multiplicar por 4
		sll $s6, $s5, 2		# ((coluna x num de linhas) + linha) x 4
		
		la $t0, matriz   	# carrega endereço base
		add $t1, $t0, $s6	# endereço base + deslocamento
		sw $s7, 0($t1)		# armazena o valor na memória
		
		addi $s2, $s2, 1
		addi $s7, $s7, 1
		
		j loop_coluna
		
	proxima_linha:
		addi $s0, $s0, 1	
		
		j loop_linha
	
	print:
		la $t0, matriz
		li $t2, 16
		move $t3, $zero
		li $t6, 16
		li $t5, 1
	
	loop_print:	
		beq $t3, $t2, proxima_linha_print
		lw $t4, 0($t0)
		
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0, 4
		la $a0, espaco
		syscall
		
		addi $t0, $t0, 4     # incrementa para acessar o proximo elemento dessa linha
		addi $t3, $t3, 1
		j loop_print
	
	proxima_linha_print:
		beq $t5, $t6, end
		li $v0, 4
		la $a0, quebra
		syscall

		move $t3, $zero
		addi $t5, $t5, 1
		
		j loop_print
	
	end:	
		li $v0, 10	# encerra o programa
		syscall

