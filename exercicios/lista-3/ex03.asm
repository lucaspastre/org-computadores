.data
vetor:
    .align 2
    .space 24     # Espaço para 6 palavras (24 bytes)

.text
    li $s0, 0x10010020   # Carregar o endereço inicial do vetor no registrador $s0

    li $s1, 1
    li $s2, 2
    li $s3, 3
    li $s4, 4
    li $s5, 5

    # Armazenar os valores no vetor usando $s0 como o endereço base
    sw $s1, 0($s0)       # vetor[0] = 1
    sw $s3, 4($s0)       # vetor[1] = 3
    sw $s2, 8($s0)       # vetor[2] = 2
    sw $s1, 12($s0)      # vetor[3] = 1
    sw $s4, 16($s0)      # vetor[4] = 4
    sw $s5, 20($s0)      # vetor[5] = 5
