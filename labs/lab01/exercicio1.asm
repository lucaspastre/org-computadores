.data
	#declarando variaveis do sistema
	b:.word 5 # declarando b
	c:.word 0 # declarando c
	d:.word 4 # declarando d
	e:.word 10 # declarando e
	
.text
	lw $t0, d
	
	add $t1, $t0, $t0 # realiza 4+4=8
	add $t2, $t1, $t1 # realiza 8+8 = 16
	
	add $t3, $t2, $t2 # realiza 16+16 = 32
	add $t4, $t3, $t3 # realiza 32+32 = 64 (valor de (4^3))
	
	lw $t5, b
	li $t6, 35
	add $t7, $t5, $t6
	
	lw $t8, e
	add $t9, $t7, $t8
	
	sub $s1, $t4, $t9
	sw $s1, c
