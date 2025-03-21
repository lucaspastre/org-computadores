.data
	end_linha:.word 0xFFFF0012
	end_teclado:.word 0xFFFF0014
	end_display:.word 0xFFFF0010

.text

main:
	# Carrega os endereços necessários
	
	lw $s2, end_linha
	lw $s3, end_teclado
	
	# Condição para cada linha da "matriz" no digital lab sim
	
	add $s0, $zero, 1	# 0001 em binário (linha 1)
	sb  $s0, 0($s2)
	lw  $s1, 0($s3)
	bne $s1, $zero, display
	
	add $s0, $zero, 2	#0010 em binario (linha 2)
	sb  $s0, 0($s2)
	lw  $s1, 0($s3)
	bne $s1, $zero, display
	
	add $s0, $zero, 4	#0100 em binário (linha 3)
	sb  $s0, 0($s2)
	lw  $s1, 0($s3)
	bne $s1, $zero, display
	
	add $s0, $zero, 8	#1000 em binário (linha 4)
	sb  $s0, 0($s2)
	lw  $s1, 0($s3)
	bne $s1, $zero, display

display:
	lw $s4, end_display
	
	beq $s1, 0x11, zero  
	beq $s1, 0x21, um	   
	beq $s1, 0x41, dois
	beq $s1, 0x81, tres
	beq $s1, 0x12, quatro
	beq $s1, 0x22, cinco
	beq $s1, 0x42, seis
	beq $s1, 0x82, sete
	beq $s1, 0x14, oito
	beq $s1, 0x24, nove
	beq $s1, 0x44, alfa_a
	beq $s1, 0x84, alfa_b
	beq $s1, 0x18, alfa_c
	beq $s1, 0x28, alfa_d
	beq $s1, 0x48, alfa_e
	beq $s1, 0x88, alfa_f
	beq $s1, 0x3F, main
	
	zero:
		li $t0, 0x3F
		sw $t0, 0($s4)
		j main
		
	um:
		li $t0, 0x06
		sw $t0, 0($s4)
		j main
		
	dois:
		li $t0, 0x5B
		sw $t0, 0($s4)
		j main
		
	tres:
		li $t0, 0x4F
		sw $t0, 0($s4)
		j main
		
	quatro:
		li $t0, 0x66
		sw $t0, 0($s4)
		j main
		
	cinco:
		li $t0, 0x6D
		sw $t0, 0($s4)
		j main
		
	seis:
		li $t0, 0x7D
		sw $t0, 0($s4)
		j main
		
	sete:
		li $t0, 0x07
		sw $t0, 0($s4)
		j main
		
	oito:
		li $t0, 0x7F
		sw $t0, 0($s4)
		j main
		
	nove:
		li $t0, 0x6F
		sw $t0, 0($s4)
		j main
		
	alfa_a:
		li $t0, 0x77
		sw $t0, 0($s4)
		j main
		
	alfa_b:
		li $t0, 0x7C
		sw $t0, 0($s4)
		j main
		
	alfa_c:
		li $t0, 0x39
		sw $t0, 0($s4)
		j main

	alfa_d:
		li $t0, 0x5E
		sw $t0, 0($s4)
		j main
		
	alfa_e:
		li $t0, 0x7B
		sw $t0, 0($s4)
		j main
		
	alfa_f:
		li $t0, 0x71
		sw $t0, 0($s4)
		j main

	end:
		li $v0, 10
		syscall
