# Projeto Final - Elevadores

.data
	end_elevador_1:.word 0xFFFF0011		# endereço do display à esquerda
	end_elevador_2:.word 0xFFFF0010		# endereço do display à direita
	end_linha:.word 0xFFFF0012	# endereço da linha do teclado
	end_coluna:.word 0XFFFF0014	# endereço da coluna do teclado
	
	andares:.byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07	# padrão para os andares 0 a 7
	
	botao_b:.word 0		# botão b = 1, então o usuário quer DESCER
	botao_c:.word 0		# botão_c = 1, então o usuário quer SUBIR
	
	elevador_1_subindo:.word 1	# se for 1, indica que o elevador 1 está SUBINDO
	elevador_2_subindo:.word 1	# se for 1, indica que o elevador 2 está SUBINDO
	
	elevador_1_descendo:.word 0	# se for 1, elevador 1 está DESCENDO
	elevador_2_descendo:.word 0	# se for 1, elevador 2 está DESCENDO
	
	msg_terreo:.asciiz "Não é possível DESCER do térreo.\n\n"
	msg_setimo:.asciiz "Não é possível SUBIR do sétimo andar.\n\n"
	
	msg_subir:.asciiz "Botão SUBIR pressionado\n\n"
	msg_descer:.asciiz "Botão DESCER pressionado\n\n"
	msg_andar:.asciiz "Andar pressionado\n\n"
	
	msg_outro_andar_subir:.asciiz "Outro andar pressionou o botão para SUBIR\n\n"
	msg_parada:.asciiz "Parou no novo andar solicitado\n\n"
	msg_outro_andar_descer:.asciiz "Outro andar pressionou o botão para DESCER\n\n"
		
	andar_atualizado:.word 0
	
.text
main:
	lw $s0, end_linha
	lw $s1, end_coluna
	lw $s4, end_elevador_2
	lw $s6, end_elevador_1
	
	# início no elevador 2 no térreo
	li $t0, 0x3F
	sw $t0, 0($s4)
	li $s5, 0	# $s5 é a posição atual do elevador 2
	
	sb $t0, 0($s6)
	li $s7, 0	# $s7 é a posição atual do elevador 1

#--------------------------------------------------------------------
leitura_botao:
	
	add $s2, $zero, 4	# linha 3 (0100 em binário)
	sb $s2, 0($s0)
	li $s3, 0
	lw $s3, 0($s1)		# lê o estado das colunas (se a tecla foi pressionada)
	bne $s3, $zero, verifica_botao
	
	add $s2, $zero, 8	# linha 4 (1000 em binário)
	sb $s2, 0($s0)
	li $s3, 0
	lw $s3, 0($s1)		# lê o estado das colunas (se a tecla foi pressionada)
	bne $s3, $zero, verifica_botao
	
	j leitura_botao		# se nenhum botão foi pressionado, continua no loop
	
verifica_botao:	
	sw $zero, botao_b
	sw $zero, botao_c
	beq $s3, 0x18, atualiza_c
	beq $s3, 0x84, atualiza_b
	
	j leitura_botao

atualiza_b:
	li $v0, 4
	la $a0, msg_descer
	syscall
	
	li $t8, 1
	sw $t8, botao_b
	j movimento

atualiza_c:
	li $v0, 4
	la $a0, msg_subir
	syscall
	li $t8, 1
	sw $t8, botao_c
	j movimento
	
movimento:
	jal ler_andar
	move $t1, $v0	# $t1 contém o andar pressionado

	move $a0, $t1
	jal escolher_elevador
	move $t6, $v0
	
	beq $t6, 2, elevador_2
	j elevador_1

elevador_2:
	blt $s5, $t1, usar_elevador_2_subir
	j usar_elevador_2_descer

elevador_1:
	blt $s7, $t1, usar_elevador_1_subir
	j usar_elevador_1_descer

#---------------------------------------------------------------------------------------------
# Elevador 2 subindo
		
usar_elevador_2_subir:
	li $t8, 1
	sw $t8, elevador_2_subindo	# status do elevador 2 passa a ser SUBINDO
	
    	addi $t1, $t1, 1
    	move $t0, $s5       # $t0 começa na posição atual do elevador 2

contador_subir_2:
    	beq $t1, $t0, fim_subir_2

    	# calcula o padrão do andar atual para o display
    	la $t3, andares
    	add $t4, $t3, $t0
    	lb $t5, 0($t4)

    	# atualiza o display
    	sw $t5, 0($s4)
    	
    	add $s2, $zero, 8	# linha 4 (1000 em binário)
	sb $s2, 0($s0)
	li $s3, 0
	lw $s3, 0($s1)		# lê o estado das colunas (se a tecla foi pressionada)
	beq $s3, 0x18, atualizar_andar_subir_2
    	
    	jal delay_andares

    	# incrementa o contador
    	addi $t0, $t0, 1
    	j contador_subir_2

fim_subir_2:
    	subi $t1, $t1, 1
    	move $s5, $t1
    	sw $zero, elevador_2_subindo
    	lw $t2, andar_atualizado
    	beq $t2, 1, deve_continuar_subindo_2
    	j leitura_botao

deve_continuar_subindo_2:
	li $v0, 4
	la $a0, msg_parada
	syscall
	
	jal delay_andares
	
	sw $zero, andar_atualizado
	move $t1, $t9
	j contador_subir_2
	
atualizar_andar_subir_2:
	li $v0, 4
	la $a0, msg_outro_andar_subir
	syscall
	
	move $t9, $t1
	
	jal ler_andar
	
	move $t1, $v0
	addi $t1, $t1, 1
	li $t2, 1
	sw $t2, andar_atualizado
	
	j contador_subir_2

#---------------------------------------------------------------------------------------------
# Elevador 1 subindo
usar_elevador_1_subir:
	li $t8, 1
	sw $t8, elevador_1_subindo	# status do elevador 1 passa a ser SUBINDO
	
    	addi $t1, $t1, 1
    	move $t0, $s7      # $t0 começa na posição atual do elevador 1

contador_subir_1:
	
    	beq $t1, $t0, fim_subir_1

    	# calcula o padrão do andar atual para o display
    	la $t3, andares
    	add $t4, $t3, $t0
    	lb $t5, 0($t4)

    	# atualiza o display
    	sb $t5, 0($s6)
	
	add $s2, $zero, 8	# linha 4 (1000 em binário)
	sb $s2, 0($s0)
	li $s3, 0
	lw $s3, 0($s1)		# lê o estado das colunas (se a tecla foi pressionada)
	beq $s3, 0x18, atualizar_andar_subir_1
	
    	jal delay_andares
    	
    	addi $t0, $t0, 1
    	j contador_subir_1

fim_subir_1:
    	subi $t1, $t1, 1
    	move $s7, $t1
    	sw $zero, elevador_1_subindo
    	lw $t2, andar_atualizado
    	beq $t2, 1, deve_continuar_subindo_1
    	
    	j leitura_botao	

deve_continuar_subindo_1:
	li $v0, 4
	la $a0, msg_parada
	syscall
	
	jal delay_andares	# delay de parada no andar
	
	sw $zero, andar_atualizado
	move $t1, $t9
	j contador_subir_1
	
atualizar_andar_subir_1:
	li $v0, 4
	la $a0, msg_outro_andar_subir
	syscall
	
	move $t9, $t1
	
	jal ler_andar
	
	move $t1, $v0
	addi $t1, $t1, 1
	li $t2, 1
	sw $t2, andar_atualizado
	
	j contador_subir_1

#---------------------------------------------------------------------------------------------
# Elevador 2 descendo
usar_elevador_2_descer:
	li $t8, 1
	sw $t8, elevador_2_descendo	# status do elevador 2 passa a ser DESCENDO
	
    	sub $t1, $t1, 1
    	move $t0, $s5       # $t0 começa na posição atual do elevador 2

contador_descer_2:
    	beq $t1, $t0, fim_descer_2

    	# calcula o padrão do andar atual para o display
    	la $t3, andares
    	add $t4, $t3, $t0
    	lb $t5, 0($t4)

    	# atualiza o display
    	sw $t5, 0($s4)
    	
    	add $s2, $zero, 4	# linha 3 (0100 em binário)
	sb $s2, 0($s0)
	li $s3, 0
	lw $s3, 0($s1)		# lê o estado das colunas (se a tecla foi pressionada)
	beq $s3, 0x84, atualizar_andar_descer_2

    	jal delay_andares

    	# decrementa o contador
    	subi $t0, $t0, 1
    	j contador_descer_2

fim_descer_2:
    	addi $t1, $t1, 1
    	move $s5, $t1
    	sw $zero, elevador_2_descendo
    	lw $t2, andar_atualizado
    	beq $t2, 1, deve_continuar_descendo_2
    	j leitura_botao
    
deve_continuar_descendo_2:
	li $v0, 4
	la $a0, msg_parada
	syscall
	
	jal delay_andares	# delay de parada no andar
	
	sw $zero, andar_atualizado
	move $t1, $t9
	j contador_descer_2

atualizar_andar_descer_2:
	li $v0, 4
	la $a0, msg_outro_andar_descer
	syscall
	
	move $t9, $t1
	
	jal ler_andar
	
	move $t1, $v0
	subi $t1, $t1, 1
	li $t2, 1
	sw $t2, andar_atualizado
	
	j contador_descer_2


#---------------------------------------------------------------------------------------------
# Elevador 1 descendo
usar_elevador_1_descer:
	li $t8, 1
	sw $t8, elevador_1_descendo	# status do elevador 1 passa a ser DESCENDO
	
    	sub $t1, $t1, 1
    	move $t0, $s7       # $t0 começa na posição atual do elevador 1

contador_descer_1:
    	beq $t1, $t0, fim_descer_1

    	# calcula o padrão do andar atual para o display
    	la $t3, andares
    	add $t4, $t3, $t0
    	lb $t5, 0($t4)

    	# atualiza o display
    	sb $t5, 0($s6)
    	
    	add $s2, $zero, 4	# linha 3 (0100 em binário)
	sb $s2, 0($s0)
	li $s3, 0
	lw $s3, 0($s1)		# lê o estado das colunas (se a tecla foi pressionada)
	beq $s3, 0x84, atualizar_andar_descer_2

   	jal delay_andares
   	
    	# decrementa o contador
    	subi $t0, $t0, 1
    	j contador_descer_1

fim_descer_1:
    	addi $t1, $t1, 1
    	move $s7, $t1
    	sw $zero, elevador_1_descendo
    	lw $t2, andar_atualizado
    	beq $t2, 1, deve_continuar_descendo_2
    	j leitura_botao

deve_continuar_descendo_1:
	li $v0, 4
	la $a0, msg_parada
	syscall
	
	jal delay_andares
	
	sw $zero, andar_atualizado
	move $t1, $t9
	j contador_descer_1

atualizar_andar_descer_1:
	li $v0, 4
	la $a0, msg_outro_andar_descer
	syscall
	
	move $t9, $t1
	
	jal ler_andar
	
	move $t1, $v0
	subi $t1, $t1, 1
	li $t2, 1
	sw $t2, andar_atualizado
	
	j contador_descer_1
#---------------------------------------------------------------------------------------------
# Procedimento para ler o andar
ler_andar:
	add $s2, $zero, 1  # linha 1 (0001 em binário)
    	sb $s2, 0($s0)
    	li $s3, 0
    	lw $s3, 0($s1)
    	bne $s3, $zero, verificacao
	
	add $s2, $zero, 2	# linha 2 (0010 em binário)
	sb $s2, 0($s0)
	li $s3, 0	
	lw $s3, 0($s1)		# lê o estado das colunas (se a tecla foi pressionada)
	bne $s3, $zero, verificacao
	
	j ler_andar
	
verificacao:
	li $v0, 4
	la $a0, msg_andar
	syscall
	
	beq $s3, 0x11, zero  
	beq $s3, 0x21, um	   
	beq $s3, 0x41, dois
	beq $s3, 0x81, tres
	beq $s3, 0x12, quatro
	beq $s3, 0x22, cinco
	beq $s3, 0x42, seis
	beq $s3, 0x82, sete

zero:
	li $s3, 0
	j retorno
um:
	li $s3, 1
	j retorno
dois:
	li $s3, 2
	j retorno
tres:
	li $s3, 3
	j retorno	
quatro:
	li $s3, 4
	j retorno	
cinco:
	li $s3, 5
	j retorno	
seis:
	li $s3, 6
	j retorno	
sete:
	li $s3, 7
	j retorno	
retorno:
	move $v0, $s3
	jr $ra

#---------------------------------------------------------------------------------------------
# Procedimento para decidir qual elevador utilizar
escolher_elevador:
    	move $t2, $s5         # posição atual do elevador 2
   	move $t3, $s7         # posição atual do elevador 1
    
    	sub $t4, $a0, $t2     # distância para elevador 2
    	abs $t4, $t4
    	sub $t5, $a0, $t3     # distância para elevador 1
    	abs $t5, $t5

    	lw $t6, botao_b       # botão DESCER pressionado
    	lw $t7, botao_c       # botão SUBIR pressionado
    
    	# Condições dos extremos
    	beq $a0, 0, andar_terreo  # Se no térreo
    	beq $a0, 7, andar_setimo  # Se no sétimo andar

    	# Prioridade: Elevador na direção do botão pressionado
    	lw $t8, elevador_1_subindo
    	lw $t9, elevador_1_descendo
    	ble $a0, $t3, verifica_descendo_1  # Se o andar solicitado está abaixo do elevador 1
    
verifica_subindo_1:
    	beq $t8, 1, usar_elevador_1  # Elevador 1 subindo e andar solicitado acima
    	j compara_elevador_2

verifica_descendo_1:
    	beq $t9, 1, usar_elevador_1  # Elevador 1 descendo e andar solicitado abaixo
    	j compara_elevador_2

compara_elevador_2:
    	lw $t8, elevador_2_subindo
   	lw $t9, elevador_2_descendo
    	ble $a0, $t2, verifica_descendo_2  # Se o andar solicitado está abaixo do elevador 2
    
verifica_subindo_2:
    	beq $t8, 1, usar_elevador_2  # Elevador 2 subindo e andar solicitado acima
    	j compara_distancia

verifica_descendo_2:
    	beq $t9, 1, usar_elevador_2  # Elevador 2 descendo e andar solicitado abaixo
    	j compara_distancia

compara_distancia:
    	ble $t4, $t5, usar_elevador_2
    	j usar_elevador_1

andar_terreo:
    	beq $t6, 1, erro_terreo  # Não pode descer DO térreo
    	j compara_elevador_2

andar_setimo:
    	beq $t7, 1, erro_setimo  # Não pode subir DO sétimo
    	j compara_elevador_2

erro_terreo:
    	li $v0, 4
    	la $a0, msg_terreo
    	syscall
    	j leitura_botao

erro_setimo:
    	li $v0, 4
    	la $a0, msg_setimo
    	syscall
    	j leitura_botao

usar_elevador_2:
    	li $v0, 2
    	jr $ra

usar_elevador_1:
    	li $v0, 1
    	jr $ra

#---------------------------------------------------------------------------------------------
# Procedimento para usar o delay de 4 segundos

delay_andares:
	li $v0, 30
	syscall
	move $t2, $a0
	move $t3, $a1

	addi $sp, $sp, -4
	sw $ra, 0($sp)

espera:
	li $v0, 30
	syscall
	
	sub $t5, $a0, $t2
	sub $t6, $a1, $t3
	bne $t6, $zero, fim
	li $t8, 4000
	blt $t5, $t8, espera

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
fim:
	jr $ra
