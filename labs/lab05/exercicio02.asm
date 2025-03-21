.data
    n:.word 0
    resultado:.word 0
    msg:.asciiz "Digite um valor para n: "
    msgR:.asciiz "Fatorial de n: "

.text

main:
	li $v0, 4		# chamada de sistema para imprimir string
	la $a0, msg 		# carrega o endereço de msg para $a0
	syscall			# imprime a string

	li $v0, 5		# chamada de sistema para ler o input do usuário
    	syscall			# faz a leitura do inteiro
    	move $a0, $v0		# move o valor lido para $a0
   	sw $v0, n    		# armazena o valor do input
    
    	jal fatorial		# chama o procedimento fatorial
    	
    	sw $v0, resultado
    	
    	li $v0, 4                  
    	la $a0, msgR              
    	syscall
            
    	li $v0, 1    
    	lw $a0, resultado
    	syscall

    	li $v0, 10
    	syscall

fatorial:
	li $t0, 1		# carrega o valor de 1 em $t0
    	ble $a0, $t0, retorno1	# se o valor de $a0 for menor ou igual a 1 então desvia para retorno1
    	
	addi $sp, $sp, -8	# aumenta a pilha para armazenar dois valores
	sw $ra, 4($sp)		# armazena o $ra da chamada atual na pilha
	sw $a0, 0($sp)		# armazena o $a0 da chamada atual na pilha
	   
    	subi $a0, $a0, 1	# decrementa o valor de n
    	
    	jal fatorial		# realiza chamada recursiva
    	
    	lw $a0, 0($sp)		# carrega da pilha o valor de n da chamada atual
    	lw $ra, 4($sp)		# carrega da pilha o endereço de retorno da chamada atual
    	addi $sp, $sp, 8	# incrementa $sp para retirar os valores da pilha
    	
    	mul $v0, $a0, $v0
    	
    	jr $ra			# retorna para o chamador

retorno1:
    	move $v0, $t0
    	jr $ra 			# retorna para o chamador
