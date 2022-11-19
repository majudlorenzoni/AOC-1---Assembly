# TRABALHO
# Bianca Beppler e Maria Júlia Lorenzoni

.data
# strings auxiliares
menu:  .asciiz "\n       ---------- MENU ----------\n       1) Adicione doadores\n       2) Busque doador\n       3) Sair do programa \nDigite sua opcao: \n"
saida: .asciiz "Programa encerrado"
stringDigiteNome: .asciiz "\n       Adicione doadores\n       Digite o seu nome: "
nome: .space 25         # espaço armazenado na memória

stringDigiteDDD: .asciiz "\n        Selecione DDD\n       1) 51 - Porto Alegre\n       2) 53 - Pelotas\n       3) 54 - Bento Goncalves\n       4) 55 - Rosário do Sul       \nDigite o seu DDD: "
ddd:
	.word 
	.align 2
	.space 16       # dd vai guardar 4 inteiros	(4 pessoas)

stringDigiteTelefone: .asciiz "\n       Adicione doadores\n       Digite o seu telefone: "
telefone: .word
	  .align 2
	  .space 36     # telefone vai guardar 1 grande inteiro

stringDigiteTipoSanguineo: .asciiz "\n       Selecione o seu tipo sanguíneo\n       1) A+     2) A-\n       3) B+     4) B-\n       5) AB+    6) AB-\n       7) O-     8)O+       \nDigite o seu tipo sanguineo: "
tipo_sanguineo:
	.word
	.align 2
	.space 8      # o vetor vair guardar 4 pessoas (tipos de sangue)
stringBusqueDoadores:  .asciiz "\n       Busque doadores\n       1) Busque por DDD\n       2) Busque por tipo sanguineo\n       Digite a sua opcao:  " 
encontrouDoadoresDDD: .asciiz " Encontramos um doador compatível com o seu DDD: "
stringNome: .asciiz "\nNome: "
stringDDD: .asciiz "\nDDD: "
stringTelefone: .asciiz "\nTelefone: "
stringTipoSanguineo: .asciiz"\nTipo Sanguineo: "
vazioDoadoresDDD: .asciiz "\n Nao ha doadores compariveis com o seu DDD "
encontrouDoadoresTipoSanguineo:  .asciiz  "\nEncontramos um doador compatível com o seu tipo sanguíneo: \n"
vazioDoadoresTipoSanguineo:  .asciiz "\nNao ha doadores disponiveis para o seu tipo sanguineo"

 # ______________________ Registradores ___________________________
 #
 #    $v0 ---> chama algumas funções
 #    $s0 ---> 
 #    $s1 ---> guarda o endereço de Nome
 #    $s2 ---> indice do vetor de DDD 
 #    $s3 ---> indice do vetor de Telefone
 #    $s4 ---> indice do vetor de Tipo Sanguíneo 
 #    $s5 ---> guarda o valor que de busqueDDD
 #    $s6 ---> guarda o valor que de busqueTipoSanguineo
 #    $s7 --->
 #    $t0 ---> guarda temporariamente informacoes para impressao  
 #    $t1 ---> 
 #    $t2 ---> tamanho do vetor DDD
 #    $t3 ---> usado para receber e enviar os valores de DDD nas funcoes de adicao e busca
 #    $t4 ---> usado para receber e enviar os valores de TELEFONE nas funcoes de adicao e busca
 #    $t5 ---> tamanho do vetor TIPO SANGUINEO
 #    $t6 ---> usado para receber e enviar os valores de TIPO SANGUINEO nas funcoes de adicao e busca
 #    $t7 ---> 
 #    $t8 ---> valor da opcao digitada no menu incial
 #    $t9 ---> 
 # _______________________________________________________________
 

.text
# Inicializacao

move $s2, $zero     # indice do vetor de DDD
move $s3, $zero     # indice do vetor de TELEFONE
move $s4, $zero     # indice do vetor de TIPO SANGUINEO
li $t2, 16          # tamanho do vetor DDD
li $t5, 16              # tamanho do vetor TIPO SANGUINEO

# Inicializa o menu
opMenu:
li $v0, 4
la $a0, menu    # imprime o menu
syscall
li $v0, 5       # lê a opcao que foi escolhida no menu
syscall

la $a0, ($v0)  # valor de v0 foi passado para a0

li $t8, 3
beq $a0, $t8, sair
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

jr $ra

# ---------- DDD - ADICIONE DOADORES ----------
adicioneDoadoresDDD:
move $t1, $zero     # valor a ser colocado no vetor
li $v0, 4
la $a0, stringDigiteDDD
syscall

li $v0, 5
syscall

move $t3, $v0      # passa o valor de v0 para t1
sw $t3, ddd   # passa o valor de t3 para o vetor ddd

jr $ra

# ---------- TELEFONE - ADICIONE DOADORES ----------
adicioneDoadoresTelefone:
li $v0, 4                      
la $a0, stringDigiteTelefone     #imprime Digite Telefone
syscall

li $v0, 5
syscall

move $t4, $v0           # passa o valor de v0 para t1
sw $t4, telefone   # passa o valor de t1 para o vetor telefone

jr $ra

# ---------- TIPO SANGUINEO - ADICIONE DOADORES ----------
adicioneDoadoresTipoSanguineo:
li $v0, 4
la $a0, stringDigiteTipoSanguineo
syscall

li $v0, 5
syscall                         # le o tipo sanguineo passado pelo usuario

move $t6, $v0                   # passa o valor de v0 para t1
sw $t6, tipo_sanguineo

jr $ra

# ---------- BUSCA DOADORES ----------
buscaDoadores:
li $v0, 4
la $a0, stringBusqueDoadores
syscall                          # imprime o menu de busca
li $v0, 5
syscall                          # le a opcao escolhida no menu

la $a0, ($v0)                    # valor de v0 foi passado para $a0
li $t8, 1
beq $a0, $t8, busqueDDD             # direciona a parte de busca por DDD
li $t8, 2
beq $a0, $t8, busqueTipoSanquineo   # direciona a parte de busca por Tipo Sanguíneo

j opMenu 

# ---------- DDD - BUSCA DOADORES ----------
busqueDDD:
li $v0, 4
la $a0, stringDigiteDDD
syscall
li $v0, 5
syscall                        # le o DDD passado pelo usuario
move $s5, $v0                  # passa o valor de v0 para $s5
j comparacaoDDD

# ------ COMPARACAO DDD - BUSCA DOADORES --------------
comparacaoDDD:

lw $t3, ddd     # chama t3 com um valor armazenado em ddd
beq $s2, $t2, naoAchouDDD     # se percorrer o loop até o final OK
beq $s5, $t3 achouDDD         # comparacao entre o valor passado e o valor que ta no vetor

# $s5 = valor que o usuario está buscando no vetor
# ddd($s2) - vetor que guarda os valores adicionados no vetor
addi $s2, $s2, 4      # "anda" com o vetor no indice do array
add $t3, $t3, $t3     # percorre os valores do vetor

# caso tenha percorrido todo o vetor e não encontrado o valor, vai pra t2
j comparacaoDDD

# --------- ACHOU DDD ---------------
achouDDD:
li $v0, 4
la $a0, encontrouDoadoresDDD
syscall
# s1 tem o endereço de nome
li $v0, 4
la $a0, stringNome
syscall
j opMenu
# Necessita mostrar as pessoas que tem o mesmo DDD que ela 

# --------- NAO ACHOU DDD ------------
naoAchouDDD:
li $v0, 4
la $a0, vazioDoadoresDDD
syscall
j opMenu

# ---------- TIPO SANGUINEO - BUSCA DOADORES ----------
busqueTipoSanquineo:
move $s2, $zero
li $v0, 4
la $a0, stringDigiteTipoSanguineo
syscall
li $v0, 5
syscall                        # le o DDD passado pelo usuario
move $s5, $v0                  # passa o valor de v0 para $s5
j comparacaoTipoSanguineo

# ------ COMPARACAO TIPO SANGUINEO - BUSCA DOADORES --------------
comparacaoTipoSanguineo:
lw $t6, tipo_sanguineo     # chama t3 com um valor armazenado tipo_sanguineo
beq $s2, $t5, naoAchouTipoSanguineo     # se percorrer o loop até o final OK
beq $s5, $t6 achouTipoSanguineo         # comparacao entre o valor passado e o valor que ta no vetor
# $s5 = valor que o usuario está buscando no vetor
addi $s2, $s2, 4      # "anda" com o vetor no indice do array
add $t6, $t6, $t6     # percorre os valores do vetor
# caso tenha percorrido todo o vetor e não encontrado o valor, vai pra t2
j comparacaoTipoSanguineo

achouTipoSanguineo:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, stringNome
syscall

j opMenu
