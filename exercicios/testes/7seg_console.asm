.data
    end_display: .word 0xFFFF0010      # endereço do display
    alfanum: .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x7B, 0x71

.text

main:
    li $v0, 12
    syscall

    move $s0, $v0

    # condição de saída
    li $t6, 's'
    beq $s0, $t6, end

    li $t0, '0'
    li $t1, '9'
    li $t2, 'a'
    li $t3, 'f'
    
    bgt $s0, $t1, checa_alpha       # Se $s0 > 8, verifica se é letra
    
    beq $s0, $t4, end
    
    # se for entre 0 e 9, calcula o indice
    sub $s1, $s0, $t0             # $s1 = $s0 - '0' (0 a 9)
    j display                       

checa_alpha:
    # Se for entre 'a' e 'f':
    sub $s1, $s0, $t2      # $s1 = $s0 - 'a' (0 a 5)
    addi $s1, $s1, 10      # $s1 = $s1 + 10 (10 a 15)

display:
    # carrega o padrão do número correspondente
    la $t0, alfanum
    add $t2, $t0, $s1
    lb $t3, 0($t2)

    # escreve o padrão no display
    lw $t4, end_display
    sb $t3, 0($t4)

    li $t5, 150000	#delay           
    
delay:
    subi $t5, $t5, 1
    bnez $t5, delay

    j main	# volta para ler outra entrada

end:
    li $v0, 10
    syscall
