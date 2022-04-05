.text 
	li $v0,4
	la $a0,e_msg
	syscall
	
	li $v0,5
	syscall
	sw $v0,e
	
	li $v0,4
	la $a0,n_msg
	syscall
	
	li $v0,5
	syscall
	sw $v0,n
	
	li $v0,4
	la $a0,txt_msg
	syscall
	
	li $v0,8
	li $a1,19
	la $a0,txt
	syscall
	
	li $v0,4
	la $a0,lf
	syscall
	
	la $t5,txt
	lb $t2,($t5)
while: 	move $a1,$t2
	lw $a2,e
	lw $a3,n
	jal mod_c
	
	move $a0,$v0
	li $v0,1
	syscall
	
	la $a0,sp
	li $v0,4
	syscall
	
	add $t5,$t5,1
	lb $t2,($t5)
	bne $t2,10,while
	
	la $a0,lf
	li $v0,4
	syscall
	
	li $v0,10
	syscall

mod_c:	move $s1,$a1 #x
	move $s2,$a2 #y
	move $s3,$a3 #p
	li $s4,1     #res
	li $t1,2
	divu $s1,$s3
	mfhi $s1
while_2: divu $s2,$t1
	 mfhi $s5
	 beq $s5,0,even
	 mul $s7,$s4,$s1
	 divu $s7,$s3
	 mfhi $s4
even:	divu $s2,$t1
	mflo $s2
	mul $s6,$s1,$s1
	divu $s6,$s3
	mfhi $s1
	bgtz $s2,while_2
	move $v0,$s4
	jr $ra
	
.data
e_msg: .asciiz "e = "
n_msg: .asciiz "n = "
txt_msg:   .asciiz "text:"
sp:	.asciiz " "
lf :	.asciiz "\n"
e:	.word 0
n:	.word 0
txt:	.space 20