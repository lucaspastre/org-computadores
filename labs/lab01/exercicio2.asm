.data
	#declarando variaveis do sistema
	b:.word 0 # declarando b
	c:.word 0 # declarando c
	d:.word 0 # declarando d
	e:.word 0 # declarando e
	msg:.asciiz "C = "
	input_b:.asciiz "Valor de b: "
	input_d:.asciiz "Valor de d: "
	input_e:.asciiz "Valor de e: "

.text
	li $v0, 4
	la $a0, input_b
	syscall
	li $v0, 5
	syscall
	sw $v0, b
	
	li $v0, 4
	la $a0, input_d
	syscall
	li $v0, 5
	syscall
	sw $v0, d
	
	li $v0, 4
	la $a0, input_e
	syscall
	li $v0, 5
	syscall
	sw $v0, e
	
	lw $t0, d
	li $t1, 0  # p/ armazenar d^2
	li $t2, 0  # p/ armazenar d^3
	move $t3, $t0 # contador p/ d^2
	move $t4, $t0 # contador p/ d^3
	
quadrado:
	beq $t3, $zero, cubo
	add $t1, $t1, $t0
	sub $t3, $t3, 1
	j quadrado
	
cubo:
	beq $t4, $zero, end
	add $t2, $t2, $t1
	sub $t4, $t4, 1
	j cubo

end:	
	lw $t5, b
	li $t6, 35
	add $t7, $t5, $t6
	
	lw $t8, e
	add $t9, $t7, $t8
	
	sub $s1, $t2, $t9
	
	sw $s1, c
	
	li $v0, 4
	la $a0, msg  
	#load adress p/ carregar o endereço de um valor na memória (.data) reg $a0
	syscall
	
	li $v0, 1
	move $a0, $s1 
	#move usado p/ copiar valor de um registador para o reg $a0
	syscall
	
	li $v0, 10
	syscall
	