.data 
a: .space 4
b: .word 5
c: .word 4
d: .word 2

.text
     lw $t1,c
     lw $t2,d
     mul $t0, $t1, $t2
     lw $t3, b
     add $t0, $t0, $t3
     sw $t0, a
     