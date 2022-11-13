# TRABALHO
# Bianca Beppler e Maria Júlia Lorenzoni

.data
# caracteres auxiliares
barra_n: .asciiz "\n"
# strings auxiliares
espaco: .asciiz " "
menu:  .asciiz "\n       ---------- MENU ----------\n       1) Adicione doadores\n       2) Busque doadores\n       3) Sair do programa \nDigite sua opcao: \n\n"
saida: .asciiz "Programa encerrado"
busqueDoadores:  .asciiz "\n       Busque doadores\n       Digite o seu tipo sanguíneo: "
encontrouDoadores:  .asciiz  "\nEsses são os doadores compatíveis com o seu tipo sanguíneo: \n"
vazioDoadores:  .asciiz "\nNao ha doadores disponiveis para o seu tipo sanguineo"

stringDigiteNome: .asciiz "\n       Adicione doadores\n       Digite o seu nome: "
nome: .space 25         # espaço armazenado na memória (limite do nome de alguém é 20 caracteres)

stringDigiteDDD: .asciiz "\n       Adicione doadores\n       Selecione DDD\n       1) 51 - Porto Alegre\n       2) 53 - Pelotas\n       3) 54 - Bento Goncalves\n       4) 55 - Rosário do Sul\n"
ddd:
	.word 
	.align 2
	.space 16       # dd vai guardar 4 inteiros	(4 pessoas)

stringDigiteTelefone: .asciiz "\n       Adicione doadores\n       Digite o seu telefone: "
telefone: .word
	  .align 2
	  .space 36     # telefone vai guardar 9 inteiros

stringDigiteTipoSanguineo: .asciiz "\n       Adicione doadores\n       Selecione o seu tipo sanguíneo\n       1) A+     2) A-\n       3) B+     4) B-\n       5) AB+     6) AB-\n       7) O-     8)O+\n"
tipo_sanguineo:
	.word
	.align 2
	.space 8      # o vetor vair guardar 4 pessoas (tipos de sangue)

stringNome:  .asciiz "Nome: "
stringTelefone:  .asciiz "Telefone: "
stringTipoSanguineo:  .asciiz "Tipo Sanguíneo: "

 # ______________________ Registradores ___________________________
 #
 #    $v0 ---> chama algumas funções
 #    $s0 ---> 
 #    $s1 ---> guarda o endereço de Nome
 #    $s2 ---> indice do vetor de DDD 
 #    $s3 ---> indice do vetor de Telefone
 #    $s4 ---> indice do vetor de Tipo Sanguíneo 
 #    $s5 ---> 
 #    $s6 --->
 #    $s7 --->
 #    $t0 ---> 
 #    $t7 ---> 
 #    $t8 ---> valor da opcao digitada no menu incial
 #    $t9 --->
 # _______________________________________________________________
 

.text
# Inicializa o menu
opMenu: 
li $v0, 4
la $a0, menu    # imprime o menu
syscall
li $v0, 5       # lê a opcao que foi escolhida no menu
syscall

la $a0, ($v0)  # valor de v0 foi passado para a0

li $t8, 3
beq $a0, $t8, sair  # caso $a0 = 3, 
li $t8, 1
beq $a0, $t8, adicioneDoadores
li $t8, 2
beq $a0, $t8, buscaDoadores

j opMenu

# ---------- SAIR ----------
sair:
li $v0, 4
la $a0, saida
syscall
li $v0, 10
syscall

# ---------- ADICIONE DOADORES ----------
adicioneDoadores:
jal adicioneDoadoresNome
jal adicioneDoadoresDDD
jal adicioneDoadoresTelefone
jal adicioneDoadoresTipoSanguineo
j opMenu

# ---------- NOME - ADICIONE DOADORES ----------
adicioneDoadoresNome:
li $v0, 4                      
la $a0, stringDigiteNome     #imprime Digite Nome
syscall

li $v0, 8
la $a0, nome                 # le o nome digitado
la $a1, 25                   # le o tamanhho do nome
syscall

la $s1, ($a0)                # coloca em s1 o endereço de nome(que estava em a0)

li $v0, 4                  #opcional
la $a0, nome
syscall

jr $ra

# ---------- DDD - ADICIONE DOADORES ----------
adicioneDoadoresDDD:
move $s2, $zero     # indice do vetor de DDD
move $t1, $zero     # valor a ser colocado no vetor
li $t2, 16          # tamanho do array (guarda 4 inteiros)

li $v0, 4
la $a0, stringDigiteDDD
syscall

li $v0, 5
syscall

move $t1, $v0      # passa o valor de v0 para t1
sw $t1, ddd($s2)   # passa o valor de t1 para o vetor ddd
addi $s2, $s2, 4   # "anda" com o vetor no indice do array
 
jr $ra

# ---------- TELEFONE - ADICIONE DOADORES ----------
adicioneDoadoresTelefone:
li $v0, 4                      
la $a0, stringDigiteTelefone     #imprime Digite Telefone
syscall

li $v0, 5
syscall

move $t1, $v0           # passa o valor de v0 para t1
sw $t1, telefone($s3)   # passa o valor de t1 para o vetor telefone
addi $s3, $s3, 4        # "anda" com o vetor

jr $ra

# ---------- TIPO SANGUINEO - ADICIONE DOADORES ----------
adicioneDoadoresTipoSanguineo:
li $v0, 4
la $a0, stringDigiteTipoSanguineo
syscall

li $v0, 5
syscall                         # le o tipo sanguineo passado pelo usuario

move $t1, $v0                   # passa o valor de v0 para t1
sw $t1, tipo_sanguineo($s4)     # passa o valor de t1 para o vetor telefone
addi $s4, $s4, 4                # "anda" com o vetor

jr $ra

# ---------- BUSCA DOADORES ----------
buscaDoadores:
