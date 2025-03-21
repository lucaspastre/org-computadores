.data
	s:.word 0
	c:.word 0
	resultado:.float 0

.text
	li $v0, 5	# recebe primeiro valor inteiro
	syscall
	sw $v0, s
	li $v0, 5	# recebe segundo valor inteiro
	syscall
	sw $v0, c
	
	jal media
	
	l.s $f12, resultado
	li $v0, 2
	syscall	
	
	li $v0, 10
	syscall

media:
	lw $t0, s
	lw $t1, c
	
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0	# conversão de inteiro para float (single precision)
	
	mtc1 $t1, $f2
	cvt.s.w $f2, $f2	# conversão de inteiro para float (single precision)
	
	li $t3, 2
	mtc1 $t3, $f4
	cvt.s.w $f4, $f4	
	
	add.s $f6, $f0, $f2
	
	div.s $f8, $f6, $f4

	s.s $f8, resultado
	
	jr $ra
