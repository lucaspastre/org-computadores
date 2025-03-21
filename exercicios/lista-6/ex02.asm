.data
	msg_fah:.asciiz "Digite a temperatura em °F: "
	msg_celsius:.asciiz "Temperatura convertida para °C: "
	temp_fah:.double 0
	temp_celsius:.double 0

.text
	li $v0, 4
	la $a0, msg_fah
	syscall

	li $v0, 7
	syscall
	s.d $f0, temp_fah

	jal conversao

	li $v0, 4
	la $a0, msg_celsius
	syscall
	
	l.d $f12, temp_celsius
	li $v0, 3
	syscall
	
	li $v0, 10
	syscall
	
conversao:
	l.d $f0, temp_fah        # Carrega a temperatura em Fahrenheit
	li $t0, 32               # Carrega o valor 32
	mtc1 $t0, $f2            # Move 32 para $f2
	cvt.d.w $f2, $f2         # Converte para double (opcional)

	sub.d $f0, $f0, $f2      # $f0 = F - 32

	li $t1, 5                # Carrega o valor 5
	mtc1 $t1, $f2            # Move 5 para $f2
	cvt.d.w $f2, $f2         # Converte para double

	mul.d $f0, $f0, $f2      # $f0 = (F - 32) * 5

	li $t2, 9                # Carrega o valor 9
	mtc1 $t2, $f2            # Move 9 para $f2
	cvt.d.w $f2, $f2         # Converte para double

	div.d $f0, $f0, $f2      # $f0 = (F - 32) * 5 / 9

	s.d $f0, temp_celsius    # Armazena a temperatura convertida em Celsius

	jr $ra                    # Retorna da função
