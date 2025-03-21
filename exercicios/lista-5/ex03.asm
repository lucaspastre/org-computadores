.data
    	buffer: .space 8       # 7 caracteres + o caractere final \0
    	qtd_a:.asciiz "\nQuantidade de caracteres 'a': "

.text
    	la $a0, buffer         # Endere�o onde a string ser� armazenada
    	li $a1, 8              # Tamanho m�ximo da string
    	li $v0, 8              # C�digo de servi�o para ler string (syscall 8)
    	syscall
	
	la $s0, buffer
	li $s1, 'a'
	li $s2, 0
	li $s3, '\0'
	
loop:
	lb $t0, 0($s0)	#load byte para carregar um �nico byte na mem�ria (caractere)
	beq $t0, $s3, end
	
	beq $t0, $s1, conta
	
	addi $s0, $s0, 1	#caractere ocupa 1 byte
	j loop

conta:
	addi $s2, $s2, 1
	addi $s0, $s0, 1
	
	j loop		#voltar pro loop (se n�o ele n�o sai daqui e $s2 fica como 1)
		
end:
	li $v0, 4
	la $a0, qtd_a
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 10
	syscall
