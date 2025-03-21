.data
    num:        .word 0
    resultado:  .word 0

.text

main:
    li $v0, 5            # chamada de sistema para ler o input do usuário
    syscall
    move $a0, $v0
    sw $v0, num          # armazena o valor do input
    
    jal fatorial	 # chama o procedimento fatorial
    
    sw $v0, resultado    # armazena o resultado na memória

    li $v0, 1            # printa usando chamada de sistema
    lw $a0, resultado
    syscall
    
    li $v0, 10           # encerra o programa
    syscall

fatorial:
    li $t0, 1
    ble $a0, $t0, retorno1
    
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    subi $a0, $a0, 1
   
    jal fatorial
    
    lw $a0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    
    mul $v0, $a0, $v0
    
    jr $ra	# retorna para o chamador

retorno1:
    move $v0, $t0
    jr $ra 	# retorna para o chamador
