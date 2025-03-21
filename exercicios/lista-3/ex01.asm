.data
    a: .word 10
    b: .word 15
    c: .word 20
    d: .word 25
    e: .word 30
    f: .word 35

    g: .word 0, 0, 0, 0
    h: .word 0, 0, 0, 0
    msg_a: .asciiz "a) "
    msg_b: .asciiz "\nb) "
    msg_c: .asciiz "\nc) "

.text
    # Operação a) G[0] = (A - (B + C) + F)
    lw $s1, b           
    lw $s2, c           
    lw $s3, a           
    lw $s4, f           
    add $s0, $s1, $s2   
    sub $s5, $s3, $s0   
    add $s0, $s5, $s4   
    sw $s0, g($zero)    

    # Operação b) G[1] = E - (A - B) * (B - C)
    lw $s0, e    
    sub $s5, $s3, $s1   
    sub $s4, $s1, $s2   
    mul $s3, $s4, $s5   
    sub $s5, $s0, $s3   
    addi $s7, $zero, 4  
    sw $s5, g($s7)      

    # Operação c) G[2] = G[1] - C
    lw $s0, g($s7)      
    lw $s1, c           
    sub $s5, $s0, $s1   
    addi $s7, $s7, 4    
    sw $s5, g($s7)

    # Imprimir G[0]
    li $v0, 4           
    la $a0, msg_a       
    syscall
    lw $a0, g($zero)   
    li $v0, 1     
    syscall

    # Imprimir G[1]
    li $v0, 4           
    la $a0, msg_b       
    syscall
    addi $s6, $zero, 4  
    lw $a0, g($s6)      
    li $v0, 1
    syscall

    # Imprimir G[2]
    li $v0, 4           
    la $a0, msg_c       
    syscall
    addi $s6, $zero, 8  
    lw $a0, g($s6)      
    li $v0, 1           
    syscall

    # chamada de sistema para encerrar o programa
    li $v0, 10
    syscall
