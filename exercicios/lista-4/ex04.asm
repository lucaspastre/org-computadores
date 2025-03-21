.data
    msg1:      .asciiz "Digite o valor do primeiro número: "
    msg2:      .asciiz "Digite o valor do segundo número: "
    msg3:      .asciiz "\nO resultado da soma é: "
    a:         .word 0
    b:         .word 0
    resultado: .word 0

.text

main:	
    jal leitura

    lw $a0, a            
    lw $a1, b 

    jal soma
	
    sw $v0, resultado
	
    li $v0, 4
    la $a0, msg3
    syscall
	

    lw $a0, resultado
    li $v0, 1
    syscall
	
    li $v0, 10
    syscall
	
leitura:
    li $v0, 4
    la $a0, msg1
    syscall
	
    li $v0, 5
    syscall
    sw $v0, a
	
    li $v0, 4
    la $a0, msg2
    syscall
	
    li $v0, 5
    syscall
    sw $v0, b
	
    jr $ra

soma:

    add $v0, $a0, $a1
	
    jr $ra
