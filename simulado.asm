# CI243 - UFPR - PROVA 1 - Nota:   (wz)
# Aluno: Maisa Carolina Moreno Girardi
# matricula: GRR20204081
# Dado o programa C abaixo (em comentarios #) gerar o programa 
#   assemby equivalente do MIPS conforme padroes 
#   de geracao de codigo estudados.
# Gerar apenas a parte relativa ao codigo (parte de dados e
# funcoes de biblioteca ja' foram inseridas abaixo

# IMPORTANTE:
# cada linha do programa foi precedida de comentarios
# assim, DEVEMOS GERAR o programa p1.s (assembly) escrevendo:
#    a) para linha programa em C inserir o 
#        codigo MIPS gerado adequadamente PARA CADA linha
#       ATENCAO: vc deve inserir codigo assembly DEPOIS da linha fonte,
#                em ORDEM, em SEQUENCIA, como no gabarito, caso nao seja seguido
#                pode nao ser possivel seguir seu codigo,
#                sera' descontado ate' 20 pts em caso nao siga essa diretiva.
#    b) MANTER o original em comentarios
#    c) escreva em assembly SEMPRE alinhando na MARGEM ESQUERDA
#    d) NAO MUDE nada nas linhas de comentarios ##, 
#       NAO MUDE o ALINHAMENTO  (-10 pts se fizer isso)

# Entrega: somente ESSE arquivo (apenas um arquivo 
#                        com o codigo de TODAS as questoes)
# - NAO DELETE nada, nem os comentarios
# - alterar esse arquivo INSERINDO CODIGO assembly entre linhas
# - o numero de cada QUESTAO estah `a direita em comentarios
# - o valor de cada questao esta' ao final desse arquivo
# - seu codigo devera' funcionar mostrando resultados 
#     mesmo se nao fizer todas as questoes
 

# obs1: o numero 32 equivale ao espaco ' ' na tabela ASCII
# obs2: o numero 10 equivale ao \n na tabela ASCII
	
	
## int main ( )                   // linha 1
.data
   n: .space 4
   l: .space 4
   c: .space 4
## {                              // linha 2
##        static int n, l, c;     // linha 3
.text
##                                     
##   n = readInt();   // le numero     // linha 4
     jal readInt
     move $t0, $v0
##                  
##   l = 0;                     // linha 11
     move $t3, $zero
##   while( l < n ) {           // linha 12
     while1: bgt $t3, $t0, exit
##         
##     c = 0;                   // linha 13
       move $t1, $zero
       subi $t2, $t0, 1
##     while( c < n ) {         // linha 14
       while2: blt $t1, $t0, se
##        if( c == (n-1) )         // linha 15 ***
          se: beq $t1, $t2, imprimeInt 
##             imprimeInt( 8 );    // linha 16 ***
##        else                     // linha 17 ***
##             imprimeInt( meuValor(l,c) );    // linha 18  ***
               jal MeuValor
               jal imprimeInt
##        imprimeChar( 32 );                   // linha 19
##        c = c + 1;                           // linha 20
          addi $t1, $t1, 1
          syscall
##     }                        // linha 21
##                  
##     imprimeChar( 10 );       // linha 22
       jal imprimeChar
##     l = l + 1;               // linha 23
       addi $t3, $t3, 1
##   }                          // linha 24
     syscall
##                     
##        exit (0);             // linha 25 
          jal exit                 
## }                            // linha 26
     

## funcao  A SER CODIFICADA por voce
## int meuValor( int l, int c )   // linha 27
MeuValor: 
## {                              // linha 28 
.text 
##    static int val;      // linha 29  
##
##    if( l <= c )         // linha 30 
      ble $t3, $t1, if
##        val = 1;         // linha 31      
          li $s0, 0 
          syscall
##    else                 // linha 32 
      if: li $s0, 1
##        val = 0;         // linha 33  
##                  
##    return( val );       // linha 34 
      jr $ra
## }                       // linha 35
  
#########  rotina para ler numero inteiro e colocar o valor em $v0
      .text 
readInt:
         li $v0, 5             # numero da funcao readInt
         syscall               # chamar funcao do SO
         jr   $ra              # return

#########  rotina para imprimir numero inteiro que estah em $a0
imprimeInt: li   $v0, 1           # especifica em $V0 a funcao a ser executada
           ## nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return
	
#########  rotina para imprimir um caracter que estah em $a0
      .text    
imprimeChar: li   $v0, 11         # especifica em $V0 a funcao a ser executada
           ## nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return

#########  rotina exit que termina programa com valor passado em  $a0
      .text 
exit:   li   $v0, 10          # system call for exit (especifica termino de programa)
        syscall               # we are out of here.  (chama SO para terminar)   
        #veja que nao tem return visto que o programa termina



