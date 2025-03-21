# lógica do while

.data
	a:.word 0
	b:.word 0
	c:.word 5
	msga:.asciiz "Valor de a: "
	msgb:.asciiz "Valor de b: "
	pulalinha:.asciiz "\n"
	
.text	
	li $v0, 4
	la $a0, msga
	syscall
	li $v0, 5
	syscall
	sw $v0, a
	
	li $v0, 4
	la $a0, msgb
	syscall
	li $v0, 5
	syscall
	sw $v0, b
	
	lw $s0, a
	lw $s1, b
	lw $s2, c
	
loop:	bge $s0, $s2, end
	addi $s0, $s0, 1	#incrementa a
	addi $s1, $s1, 2	#incrementa b
	j loop

end:	
	sw $s0, a
	sw $s1, b
	li $v0, 4
	la $a0, msga
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, pulalinha
	syscall
	li $v0, 4
	la $a0, msgb
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 10
	syscall
	