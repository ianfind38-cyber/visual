.data
    msg1: .asciiz "HOLA SOY IAN"
.text
main:
    la $a0, msg1
    jal es_minuscula
    li $v0, 4
    la $a0, msg1
    syscall
    li $v0, 10
    syscall
es_minuscula:
    move $t0, $a0
    li $t2, 65
    li $t3, 90
loop:
    lb $t1, 0($t0)
    beq $t1, $zero, fin
    blt $t1, $t2, siguiente    
    bgt $t1, $t3, siguiente    
    addi $t1, $t1, 32
    sb $t1, 0($t0)
siguiente:
    addi $t0, $t0, 1    
    j loop
fin: 
    jr $ra