.text
	jal sel_p
	jal sel_q
	jal prnt_e
	jal calc_n
	jal calc_phi
	
	#afisarea si calculul lui d 
	li $v0,4
	la $a0,d_msg
	syscall
	lw $t3,e
	move $a1,$t3
	lw $t3,phi
	move $a2,$t3
	jal mod_inv
	sw $v0,d
	move $t3,$v0
	move $a0,$t3
	li $v0,1
	syscall
	li $v0,4
	la $a0,lf
	syscall
	
	li $v0,10 #Halt
	syscall
	
# calculez d astfel in incat ((d*e) mod n) = 1
# algoritmul este preluat de aici 
# https://www.geeksforgeeks.org/multiplicative-inverse-under-modulo-m/
	
mod_inv: move $s1,$a1 #a
	 move $s2,$a2 #m
	 li $s3,0     #y
	 li $s4,1     #x
while_1: div $s1,$s2  
	 mflo $s5     #q
	 move $s6,$s2 #t
	 mfhi $s2     
	 move $s1,$s6
	 move $s6,$s3
	 mul $s7,$s5,$s3
	 sub $s3,$s4,$s7
	 move $s4,$s6
	 bgt $s1,1,while_1
end:	 bgez $s4,fin
	 add $s4,$s4,$a2
fin:	 move $v0,$s4
	 jr $ra	 
	 

sel_p:  li $v0,4
	la $a0,p_msg
	syscall
	la $s1,p_set		# mi-am declarat un array cu prime_nr elemente
	lw $t1,prime_nr
	move $a1,$t1
	li $v0,42		# syscall 42 alege random un numar cu val maxima $a1 (prime_nr)
	syscall
	move $s2,$a0
	mul $s3,$s2,4		# stiu ca un int este 4B deci adresele sunt din 4 in 4
	add $s1,$s1,$s3 	# la adresa de start adaug 4 * numarul ales random
	lw $t0,($s1)		# dereferentiez valoarea adresei si dau de numarul dorit
	sw $t0,p
	move $a0,$t0
	li $v0,1
	syscall
	li $v0,4
	la $a0,lf
	syscall
	jr $ra

sel_q:  li $v0,4
	la $a0,q_msg
	syscall
	la $s1,q_set
	lw $t1,prime_nr		# fac acelasi lucru ca si pentru nr-ul p
	move $a1,$t1
	li $v0,42
	syscall
	move $s2,$a0
	mul $s3,$s2,4
	add $s1,$s1,$s3
	lw $t0,($s1)
	sw $t0,q
	move $a0,$t0
	li $v0,1
	syscall
	li $v0,4
	la $a0,lf
	syscall
	jr $ra

prnt_e: li $v0,4		# afisez valoarea e
	la $a0,e_msg
	syscall
	lw $a0,e
	li $v0,1
	syscall
	li $v0,4
	la $a0,lf
	syscall
	jr $ra
	
calc_n: li $v0,4		# calculez n
	la $a0,n_msg
	syscall
	lw $t0,p
	lw $t1,q
	mul $t2,$t1,$t0		# n = p * q
	sw $t2,n
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,lf
	syscall
	jr $ra

calc_phi: li $v0,4		# calculez phi
	  la $a0,phi_msg
	  syscall
	  lw $t0,p
	  lw $t1,q
	  sub $t0,$t0,1
	  sub $t1,$t1,1
	  mul $t2,$t1,$t0	# phi = ( p - 1 ) * ( q - 1 )
	  sw  $t2,phi
	  move $a0,$t2
	  li $v0,1
	  syscall
	  li $v0,4
	  la $a0,lf
	  syscall
	  jr $ra


	
.data
p:	.word  0
q:	.word  0
phi:	.word  0
e:	.word 17
d:	.word 0
n:	.word 0
lf:	.asciiz "\n"
n_msg:	.asciiz "n:"
phi_msg: .asciiz "phi:"
e_msg: .asciiz "e:"
p_msg: .asciiz "p:"
q_msg: .asciiz "q:"
d_msg: .asciiz "d:"
prime_nr: .word 14
p_set : .word 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337
q_set : .word 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503
