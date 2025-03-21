# lógica do switch

.data
	a:.word 0
	b:.word 0
	c:.word 0
	msga:.asciiz "Valor de a: "
	msgb:.asciiz "Valor de b: "
	msgc:.asciiz "Valor de c: "
	pulalinha:.asciiz "\n"

.text	
	li $v0, 5
	syscall
	sw $v0, a
	li $v0, 5
	syscall
	sw $v0, c

	lw $s0, a
	li $s1, 1
	lw $s2, c
	li $s3, 2
	
	beq $s0, $s1, case1
	beq $s0, $s3, case2
	j default
	
case1:
	addi $s4, $s2, 1
	sw $s4, b
	j end
	
case2:
	addi $s4, $s2, 2
	sw $s4, b
	j end

default:
	sw $s2, b

end: 
	li $v0, 10
	syscall

