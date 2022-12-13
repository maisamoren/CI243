.text
j main

#	int min (int a, int b) {
.text
min:
#		static int m;
.data
m: .space 4

.text
#		if(a < b)
		if1:
		  lw $t0, a
		  lw $t1, b
		  slt $t0, $t0, $t1
		  beq $t0, $0, else1
#			m = b;
			lw $t0, b
			sw $t0, m
			j fimIf1
#		else
		else1:
#			m = a;
			lw $t0, a
			sw $t0, m
		fimIf1:
#		return (m);
		lw $v0, m
		jr $ra
#	}



#	int max (int a, int b) {
.text 
max:
#		static int mm;
.data
mm: .space 4

.text
#		if (a > b)
		if2:
		  lw $t0, a
		  lw $t1, b
		  sgt $t0, $t0, $t1
		  beq $t0, $0, else2
#			mm = a;
			lw $t0, a
			sw $t0, mm
			j fimIf2
#		else
		else2:
#			mm = b;
			lw $t0, b
			sw $t0, mm
		fimIf2:
#		return (mm);
		lw $v0, mm
		jr $ra
#	}



#	int somatorio (int n1, int n2){
.text 
somatorio:
#		static int ss=0, i;
.data
ss: .word 0
i: .space 4 

.text
#		i = n1; // note que n1 é o primeiro parametro e está em $a0
		sw $a0, i
#		while (i < n2) {
		while1:
			   lw $t0, i
#			   // note que n2 é o segundo parametro e está em $a1
			   slt $t0, $t0, $a1
			   beq $t0, $0, fimWhile1
#			ss = ss + i;
			lw $t0, ss
			lw $t1, i
			add $t0, $t0, $t1
			sw $t0, ss
#			i++;
			lw $t0, i
			addi $t0, $t0, 1
			sw $t0, i
		j while1
#		}
		fimWhile1:
#		return (ss);
		lw $v0, ss
		jr $ra
# 	}



# int main (void) {
.text 
main:
# 	static int a;
#	static int b;
#	static int maior;
#	static int menor;
#	static int s;
.data
a: .space 4
b: .space 4
maior: .space 4
menor: .space 4
s: .space 4

.text
#	a = readInt();
	jal readInt
	sw $v0, a
#	b = readInt();
	jal readInt
	sw $v0, b
#
#	maior = max (a,b);
	lw $a0, a
	lw $a1, b
	jal max
	sw $v0, maior
#	menor = min (a,b);
	lw $a0, a
	lw $a1, b
	jal min
	sw $v0, menor
#
#	imprimeInt (menor);
	lw $a0, menor
	jal imprimeInt 
#	imprimeChar ('<');
	li $a0, '<'
	jal imprimeChar
#	imprimeInt (maior);
	lw $a0, maior
	jal imprimeInt
#	imprimeChar ('\n');
	li $a0, '\n'
	jal imprimeChar
#	
#	s = somatorio (menor, maior);
	lw $a0, menor
	lw $a1, maior
	jal somatorio
	sw $v0, s	
#	
#	imprimeInt (s);
	lw $a0, menor
	jal imprimeInt
#	imprimeChar('\n');
	li $a0, '\n'
	jal imprimeChar
#
#	exit (0);
	li $a0, 0 
	jal exit
# }

#########  rotina para ler numero inteiro e colocar o valor em $v0
      .text 
readInt:
         li $v0, 5             # numero da funcao readInt
         syscall               # chamar funcao do SO
         jr   $ra              # return

#########  rotina para imprimir numero inteiro que estah em $a0
      .text 
imprimeInt: li   $v0, 1           # especifica em $V0 a funcao a ser executada
                                  # nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return
	
#########  rotina para imprimir um caracter que estah em $a0
      .text    
imprimeChar: li   $v0, 11         # especifica em $V0 a funcao a ser executada
                                  # nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return

#########  rotina exit que termina programa com valor passado em  $a0
      .text 
exit:   li   $v0, 10          # system call for exit (especifica termino de programa)
        syscall               # we are out of here.  (chama SO para terminar)   
        #veja que nao tem return visto que o programa termina