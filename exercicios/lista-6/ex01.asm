.data
	raio:.double 0
	area:.double 0
	pi:.double 3.141592653589793
	msg:.asciiz "Digite o raio do círculo: "
	area_msg:.asciiz "Área: "

.text
	li $v0, 4
	la $a0 msg
	syscall
	li $v0, 7
	syscall
	s.d $f0, raio
	
	jal calcula_area
	
	li $v0, 4
    	la $a0, area_msg
    	syscall
    	l.d $f12, area	#argumento $f12 ao invés de $a0
    	li $v0, 3
    	syscall
    	
    	li $v0, 10	#sempre lembrar de finalizar o programa
    	syscall
    	
calcula_area:
	l.d $f0, raio
	l.d $f2, pi
	
	mul.d $f4, $f0, $f0
	mul.d $f6, $f2, $f4
	
	s.d $f6, area
	
	jr $ra
	
