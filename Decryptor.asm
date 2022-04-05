.text 
	li $v0,4
	la $a0,d_msg
	syscall
	
	li $v0,5
	syscall
	sw $v0,d
	
	li $v0,4
	la $a0,n_msg
	syscall
	
	li $v0,5
	syscall
	sw $v0,n
	
	li $v0,4
	la $a0,lf
	syscall
	
	li $v0,5
	syscall
	sw $v0,nr
	
	la $t5,txt
	
while:	lw $a1,nr
	lw $a2,d
	lw $a3,n
	jal mod_c
	sb $v0,($t5)
	
	li $v0,5
	syscall
	sw $v0,nr
	add $t5,$t5,1
	bnez $v0,while
	
	li $t2,0
	sb $t2,($t5)
	
	la $a0,txt
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
d_msg: .asciiz "d = "
n_msg: .asciiz "n = "
txt_msg:   .asciiz "text:"
sp:	.asciiz " "
lf :	.asciiz "\n"
d:	.word 0
n:	.word 0
nr:	.word 0
txt:	.space 20
