.data
	entrada:.byte 1 2 -2 -3 -4
	.align 2
	a:.word 0
	b:.word 0

.text
	la $s2, entrada
	lb $s0, 2($s2)
	lbu $s1, 3($s2)
	
	sb $s0, a
	sb $s1, b
