# TRABALHO
# Bianca Beppler e Maria Júlia Lorenzoni

# Problemas:
# O vetor do tipo Sanguineo não está funcionando como deveria na funçao BuscarTipoSanguineo
# O vetores de DDD, TELEFONE e TIPO SANGUINEO não estão atualizando para mostrar as pessoas
# Para mostrar pessoas, a pessoa não está atualizando 
.data
ddd:
	.word 
	.align 2
	.space 16       # dd vai guardar 4 inteiros	(4 pessoas)
tipo_sanguineo:
	.word
	.align 2
	.space 16      # o vetor vair guardar 4 pessoas (tipos de sangue)
telefone: 
	.word
	.align 2
	.space 36     # telefone vai guardar 1 grande inteiro
	  
nome: 	.space 25         # espaço armazenado na memória
menu:	.asciiz "\n       ---------- MENU ----------\n       1) Adicione doadores\n       2) Busque doador\n       3) Mostrar doadores armazenados\n       4) Sair do programa \nDigite sua opcao: \n"
saida:	.asciiz "Programa encerrado"

stringDigiteNome:	.asciiz "\n       Adicione doadores\n       Digite o seu nome: "
stringDigiteDDD:	.asciiz "\n        Selecione DDD\n       1) 51 - Porto Alegre\n       2) 53 - Pelotas\n       3) 54 - Bento Goncalves\n       4) 55 - Rosário do Sul       \nDigite o seu DDD: "
stringDigiteTelefone:	.asciiz "\n       Adicione doadores\n       Digite o seu telefone: "
stringDigiteTipoSanguineo:	.asciiz "\n       Selecione o seu tipo sanguíneo\n       1) A+     2) A-\n       3) B+     4) B-\n       5) AB+    6) AB-\n       7) O-     8)O+      \nDigite o seu tipo sanguineo: "
stringBusqueDoadores:  		.asciiz "\n       Busque doadores\n       1) Busque por DDD\n       2) Busque por tipo sanguineo\n       Digite a sua opcao:  " 

stringNome:		.asciiz "Nome: "
stringDDD: 		.asciiz "DDD: "
stringTelefone:		.asciiz "\nTelefone: "
stringTipoSanguineo: 	.asciiz"\nTipo Sanguineo: "

vazioDoadoresDDD: 	.asciiz "\n Nao ha doadores compariveis com o seu DDD "
encontrouDoadoresDDD:	 .asciiz " Encontramos um doador compatível com o seu DDD: "
encontrouDoadoresTipoSanguineo:  .asciiz  "\nEncontramos 1 doador compatível com o seu tipo sanguíneo: \n"
vazioDoadoresTipoSanguineo:  .asciiz "\nNao ha doadores disponiveis para o seu tipo sanguineo"

compativelA1: 	.asciiz "\n Os doadores compativeis com voce são dos tipos: A+, A-, O+, O-"
compativelA2: 	.asciiz"\n Os doadores compativeis com voce são dos tipos: A-, O-"
compativelB1: 	.asciiz"\n Os doadores compativeis com voce são dos tipos: B+, B-, O+, O-"
compativelB2: 	.asciiz"\n Os doadores compativeis com voce são dos tipos: B-, O-"
compativelAB1:	 .asciiz"\n Os doadores compativeis com voce são dos tipos: A+, A-, B+, B-, O+, O-, AB+, AB-"
compativelAB2:	 .asciiz"\n Os doadores compativeis com voce são dos tipos: A-, B-, O-, AB-"
compativelO1:	 .asciiz "\n Os doadores compativeis com voce são dos tipos: O+, O-"
compativelO2:	 .asciiz "\n Os doadores compativeis com voce são dos tipos: O-"
agendaCheia:	.asciiz "\n Esta agenda armazena 4 pessoas, ela está lotada! O programa será encerrado!"
 # ______________________ Registradores ___________________________
 #
 #    $v0 ---> chama algumas funções
 #    $s0 ---> recebe o endereço da string nome
 #    $s1 ---> recebe os bytes do endereço string
 #    $s2 ---> indice do vetor de DDD 
 #    $s3 ---> indice do vetor de Telefone
 #    $s4 ---> indice do vetor de Tipo Sanguíneo 
 #    $s5 ---> guarda o valor que de busqueDDD
 #    $s6 ---> 
 #    $s7 ---> contador pra percorrer nome
 #    $t0 ---> guarda temporariamente informacoes para impressao  
 #    $t1 ---> contador 
 #    $t2 ---> tamanho do vetor DDD // tamanho do vetor TIPO SANGUINEO
 #    $t3 ---> usado para receber e enviar os valores de DDD nas funcoes de adicao e busca
 #    $t4 ---> usado para receber e enviar os valores de TELEFONE nas funcoes de adicao e busca
 #    $t5 ---> tamanho do vetor TIPO SANGUINEO
 #    $t6 ---> usado para receber e enviar os valores de TIPO SANGUINEO nas funcoes de adicao e busca
 #    $t7 ---> 
 #    $t8 ---> valor da opcao digitada no menu incial
 #    $t9 ---> auxiliar de contador pessoas
 # _______________________________________________________________
 
.text
# Inicializacao
la $s1, nome		#  indice do vetor NOME
la $s2, ddd		# carrega $s4 com o endereco de memoria de ddd

li $t1, 4		#  iniciliza contador com 4	( a agenda armazena apenas 4 pessoas)
li $t2, 16     		#  tamanho do vetor DDD
li $a3, 0
# Inicializa o menu
opMenu:
li $v0, 4
la $a0, menu    # imprime o menu
syscall
li $v0, 5       # lê a opcao que foi escolhida no menu
syscall
la $a0, ($v0)  # valor de v0 foi passado para a0

li $t8, 4
beq $a0, $t8, sair
li $t8, 1
beq $a0, $t8, adicioneDoadores
li $t8, 2
beq $a0, $t8, buscaDoadores
li $t8, 3
beq $a0, $t8, mostraDoadores
j opMenu

# ---------- AGENDA LOTADA ----------
agendaLotada:
li $v0, 4
la $a0, agendaCheia
syscall
li $v0, 10
syscall

# ---------- SAIR ----------
sair:
li $v0, 4
la $a0, saida
syscall
li $v0, 10
syscall

# ---------- ADICIONE DOADORES ----------
adicioneDoadores:
beq $t9, $t1, agendaLotada
addi $t9, $t9, 1

jal adicioneDoadoresNome
jal adicioneDoadoresDDD
jal adicioneDoadoresTelefone
jal adicioneDoadoresTipoSanguineo
j opMenu
# ---------- NOME - ADICIONE DOADORES ----------
adicioneDoadoresNome:

li $v0, 4                      
la $a0, stringDigiteNome	#imprime Digite Nome
syscall

li $v0, 8
move $a0, $s1
la $a0, ($s1)			# le o nome digitado
la $a1, 25			# le o tamanhho do nome
syscall

loopPraArmazenarNome:
lb $s0, 0($s1)			# carrega s0 com um valor amazenado em NOME
li $s7, 10			# verifica se o nome chegou ao fim (\n = 10)
beq $s0, $s7 sairNome		# enquanto não chega no final do nome, vai armazendo na m
addi $s1, $s1, 1		# percorrendo o espaço pra não reescrever o nome
j loopPraArmazenarNome

# Um nome sobrescreve outro
sairNome:		
addi $s1, $s1, 1		# coloca um /0 no final da string
jr $ra

# ---------- DDD - ADICIONE DOADORES ----------
adicioneDoadoresDDD:

li $v0, 4
la $a0, stringDigiteDDD
syscall

li $v0, 5
syscall
move $t3, $v0    	# passa o valor de v0 para t3

sw $t3, 0($s2)   	# passa o valor de t3 para o vetor ddd
addiu $s2, $s2, 4	# anda com o vetor ddd

# O DDD não atualiza para 
jr $ra

# ---------- TELEFONE - ADICIONE DOADORES ----------
adicioneDoadoresTelefone:
la $s3, telefone	#   carrega $s3 com o endereco de memoria de TELEFONE

li $v0, 4                      
la $a0, stringDigiteTelefone 
syscall

li $v0, 5
syscall
move $t4, $v0           # passa o valor de v0 para t4

sw $t4, 0($s3)    	# passa o valor de t1 para o vetor telefone
addiu $s3, $s3, 4	# anda com o vetor telefone
jr $ra

# ---------- TIPO SANGUINEO - ADICIONE DOADORES ----------
adicioneDoadoresTipoSanguineo:
la $s4, tipo_sanguineo		#  carrega $s4 com o endereco de memoria de tipo sanguineo

li $v0, 4
la $a0, stringDigiteTipoSanguineo
syscall

li $v0, 5
syscall                         # le o tipo sanguineo passado pelo usuario
move $t6, $v0                   # passa o valor de v0 para t1

sw $t6, 0($s4) 			# passa o valor de t3 para o vetor tipo sanguineo
addiu $s4, $s4, 4		# anda com o vetor tipo sanguineo

jr $ra

mostraDoadores:
la $s1, nome
li $s7, 1			# verifica se o nome chegou ao fim (novalinha = 1)
li $v0, 4
la $a0, stringNome
syscall

mostrarNome:
lb $t7, 0($s1)			# carrega s0 com um valor amazenado em NOME

li $v0, 11
la $a0, ($t7)
syscall

mostrarNome2:
lb $s0, 0($s1)			# carrega s0 com um valor amazenado em NOME
beq $s0, $s7 mostrarDoadores3	# enquanto não chega no final do nome, vai armazendo na m
addi $s1, $s1, 1		# percorrendo o espaço pra não reescrever o nome
j mostrarNome

mostrarDoadores3:
li $v0, 4
la $a0, stringDDD
syscall

lw $t7, 0($s2)			# carrega valor da memoria (ddd[i])
li $v0, 1
move $a0, $t7
syscall
addiu $s2, $s2, 4

li $v0, 4
la $a0, stringTelefone
syscall
lw $t3, 0($s3)   	# passa o valor de t3 para o vetor ddd
li $v0, 1
move $a0, $t3
syscall
addiu $s3, $s3, 4
li $v0, 4
la $a0, stringTipoSanguineo
syscall

lw $t6, 0($s4) 			# passa o valor de t3 para o vetor tipo sanguineo
li $v0, 1
move $a0, $t6
syscall

addi $s4, $s4, 4

addi $a3, $a3, 4

ble $a3, $t2 mostraDoadores
j opMenu
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
la $s2, ddd			#  indice do vetor de DDD
li $v0, 4
la $a0, stringDigiteDDD
syscall
li $v0, 5
syscall                    	    # le o DDD passado pelo usuario
move $s5, $v0              	    # passa o valor de v0 para $s5
j comparacaoDDD

# ------ COMPARACAO DDD - BUSCA DOADORES --------------
comparacaoDDD:

lw $t7, 0($s2)			# carrega valor da memoria (ddd[i])
beq $s7, $t2, naoAchouDDD	# se percorrer o loop até o final OK // $t2 é o tamanho do vetor
beq $s5, $t7 achouDDD         	# comparacao entre o valor passado e o valor que ta no vetor
addi $s2, $s2, 4      		# "anda" com o vetor no indice do array
addi $s7, $s7, 4      		# "anda" com o vetor no indice do array
j comparacaoDDD

# --------- ACHOU DDD ---------------
achouDDD:
li $v0, 4
la $a0, encontrouDoadoresDDD
syscall

li $t7, 0
j opMenu

# --------- NAO ACHOU DDD ------------
naoAchouDDD:
li $v0, 4
la $a0, vazioDoadoresDDD
syscall

li $t7, 0
j opMenu

# ---------- TIPO SANGUINEO - BUSCA DOADORES ----------
busqueTipoSanquineo:
la $s4, tipo_sanguineo

li $v0, 4
la $a0, stringDigiteTipoSanguineo
syscall
li $v0, 5
syscall                        # le o DDD passado pelo usuario
move $s5, $v0                  # passa o valor de v0 para $s5
li $s7, 16
j comparacaoTipoSanguineo

comparacaoTipoSanguineo:
li $t6, 1
beq $s5, $t6 compativelUM
li $t6, 2
beq $s5, $t6, compativelDOIS
li $t6, 3
beq $s5, $t6, compativelTRES
li $t6, 4
beq $s5, $t6, compativelQUATRO
li $t6, 5
beq $s5, $t6, compativelCINCO
li $t6, 6
beq $s5, $t6, compativelSEIS
li $t6, 7
beq $s5, $t6, compativelSETE
li $t6, 8
beq $s5, $t6, compativelOITO

j naoAchouTipoSanguineo	# se percorrer o loop até o final OK // $t2 é o tamanho do vetor

compativelUM:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, compativelA1
syscall
j opMenu

compativelDOIS:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, compativelA2
syscall
j opMenu

compativelTRES:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, compativelB1
syscall
j opMenu

compativelQUATRO:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, compativelB2
syscall
j opMenu

compativelCINCO:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, compativelAB1
syscall
j opMenu

compativelSEIS:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, compativelAB2
syscall
j opMenu

compativelSETE:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, compativelO1
syscall
j opMenu

compativelOITO:
li $v0, 4
la $a0, encontrouDoadoresTipoSanguineo
syscall
li $v0, 4
la $a0, compativelO2
syscall
j opMenu

# --------- NAO ACHOU TIPO SANGUINEO ---------------
naoAchouTipoSanguineo:
li $v0, 4
la $a0, vazioDoadoresTipoSanguineo
syscall
li $t7, 0
j opMenu
