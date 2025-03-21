.data
	a:.float 0
	b:.float 0
	raiz:.float 0

.text
	li $v0, 6
	syscall
	s.s $f0, a
	li $v0, 6
	syscall
	s.s $f0, b
	
	jal calcula_raiz
	
	l.s $f12, raiz
	li $v0, 2
	syscall	

	li $v0, 10
	syscall

calcula_raiz:
	# x = -b/a calcula a raiz para a eq. do primeiro grau
	# ou seja, multiplicamos b por -1 e dividimos por a
	
	l.s $f0, a
	l.s $f2, b
	
	li $t0, -1
	mtc1 $t0, $f4
	cvt.s.w $f4, $f4
	
	mul.s $f6, $f4, $f2
	
	div.s $f8, $f6, $f0
	
	s.s $f8, raiz
	
	jr $ra
	
	
	
