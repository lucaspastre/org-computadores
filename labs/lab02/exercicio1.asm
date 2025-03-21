.data
	end_display:.word 0xFFFF0010      # Endere�o do display
	numeros:.byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

.text
main:
    li $t0, 0		# In�cio do contador
    li $t1, 10          # Fim do contador    

loop:
    beq $t0, $t1, end              # Se $t0 == 10, sai do loop

    la $t3, numeros                # carrega o endere�o base da tabela de n�meros
    add $t4, $t3, $t0              # ajusta o endere�o, de acordo com o contador
    lb $t5, 0($t4)                 # carrega o padr�o correspondente ao n�mero em $t5

    lw $t6, end_display            # Carrega o endere�o do display em $t6
    sb $t5, 0($t6)                 # Escreve o padr�o no display de 7 segmentos

    # Atraso
    li $t7, 500000
    
delay:
    subi $t7, $t7, 1
    bnez $t7, delay

    addi $t0, $t0, 1               # Incrementa o contador
    j loop

end:
    li $v0, 10                     # Finaliza o programa
    syscall