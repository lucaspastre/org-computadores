.data
	endereco:.word 0x10010020
	msg_inf:.asciiz "Digite 1 para ligar e 0 para desligar o bit: "
	msg_inf_posicao:.asciiz "Digite qual bit deseja mudar (0-31): "
	inf:.byte 0
	inf_posicao:.byte 0

#---------------------------------------------
.text
	li $v0, 4
	la $a0, msg_inf
	syscall
	li $v0, 1
	syscall
	sb $v0, inf

	li $v0, 4
	la $a0, msg_inf_posicao
	syscall
	li $v0, 1
	syscall
	sb $v0, inf_posicao
#---------------------------------------------
	la $s0, endereco
	lb $s1, 0($s0)
	lb $s2 inf_posicao
	
	#cria a máscara
	li $s4, 1	
	sllv $s4, $s4, $s2
	
	lb $s3, inf
	li $t0, 1
	beqz $s3, desligar
	beq $s3, $t0, ligar

ligar:
	#OR bit a bit para ligar
	or $s3, $s3, $s4
	sb $s3, 0($s0)
	j fim
	
desligar:
	#AND bit a bit para desligar
	nor $s4, $s4, $zero  #inverter máscara
	and $s3, $s3, $s4
	sb $s3, 0($s0)
	j fim
	
fim:
	li $v0, 10
	syscall
	
	