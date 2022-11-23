# TRABALHO
# Bianca Beppler e Maria Júlia Lorenzoni
# A agenda é capaz de adicionar pessoas, mostrar quem foi adicionado e fazer algumas buscas
# Todos os critérios do trabalho foram atendidos
# Tratamento de erros foi adicionado
.data
ddd:
	.word 
	.align 2
	.space 16       # ddd vai guardar 4 inteiros	(4 pessoas)
tipo_sanguineo:
	.word
	.align 2
	.space 16      # o vetor vair guardar 4 pessoas (tipos de sangue)
telefone: 
	.word
	.align 2
	.space 36     # telefone vai guardar 1 grande inteiro
	  
nome1: 	.space 12         # espaço armazenado na memória
nome2:	.space 12         # espaço armazenado na memória
nome3:	.space 12         # espaço armazenado na memória
nome4:	.space 12         # espaço armazenado na memória
menu:	.asciiz "\n       ---------- MENU ----------\n       1) Adicione doadores\n       2) Busque doador\n       3) Mostrar doadores armazenados\n       4) Sair do programa \nDigite sua opcao: "
saida:	.asciiz "Programa encerrado"
stringDigiteNome:	.asciiz "\n       Adicione doadores\n       Digite o seu nome: "
stringDigiteDDD:	.asciiz "\n        Selecione DDD\n       1) 51 - Porto Alegre\n       2) 53 - Pelotas\n       3) 54 - Bento Goncalves\n       4) 55 - Rosário do Sul       \nDigite o seu DDD: "
stringDigiteTelefone:	.asciiz "\n       Adicione doadores\n       Digite o seu telefone: "
stringDigiteTipoSanguineo:	.asciiz "\n       Selecione o seu tipo sanguíneo\n       1) A+     2) A-\n       3) B+     4) B-\n       5) AB+    6) AB-\n       7) O-     8)O+      \nDigite o seu tipo sanguineo: "
stringBusqueDoadores:  		.asciiz "\n       Busque doadores\n       1) Busque por DDD\n       2) Busque por tipo sanguineo\n       Digite a sua opcao:  " 

stringNome:		.asciiz "\nNome: "
stringDDD: 		.asciiz "DDD: "
stringTelefone:		.asciiz "\nTelefone: "
stringTipoSanguineo: 	.asciiz"\nTipo Sanguineo: "

vazioDoadoresDDD: 	.asciiz "\n Nao ha doadores compariveis com o seu DDD!! "
encontrouDoadoresDDD:	 .asciiz " Encontramos um doador compatível com o seu DDD!!"
encontrouDoadoresTipoSanguineo:  .asciiz  "\nEncontramos 1 doador compatível com o seu tipo sanguíneo!!! \n Veja os doadores armazenados na opcao 3 do MENU"
vazioDoadoresTipoSanguineo:  .asciiz "\nNao ha doadores disponiveis para o seu tipo sanguineo"

compativelA1: 	.asciiz "\n Os doadores compativeis com voce são dos tipos: A+, A-, O+, O-"
compativelA2: 	.asciiz"\n Os doadores compativeis com voce são dos tipos: A-, O-"
compativelB1: 	.asciiz"\n Os doadores compativeis com voce são dos tipos: B+, B-, O+, O-"
compativelB2: 	.asciiz"\n Os doadores compativeis com voce são dos tipos: B-, O-"
compativelAB1:	 .asciiz"\n Os doadores compativeis com voce são dos tipos: A+, A-, B+, B-, O+, O-, AB+, AB-"
compativelAB2:	 .asciiz"\n Os doadores compativeis com voce são dos tipos: A-, B-, O-, AB-"
compativelO1:	 .asciiz "\n Os doadores compativeis com voce são dos tipos: O+, O-"
compativelO2:	 .asciiz "\n Os doadores compativeis com voce são dos tipos: O-"
agendaCheia:	.asciiz "\n Esta agenda armazena 4 pessoas, ela está lotada! Agora, apenas as funcoes de exibicao e busca estão disponíveis"
opcaoInvalida: .asciiz "Opcao invalida! Escolha uma das opcões viáveis!"
 # ______________________ Registradores ___________________________
 #
 #    $v0 ---> chama algumas funções
 #    $s0 ---> recebe o endereço da string nome1
 #    $s1 ---> recebe o endereço da string nome2
 #    $s2 ---> indice do vetor de DDD 
 #    $s3 ---> indice do vetor de Telefone
 #    $s4 ---> indice do vetor de Tipo Sanguíneo 
 #    $s5 ---> guarda o valor que de busqueDDD
 #    $s6 ---> recebe o endereço da string nome3
 #    $s7 ---> usado em buscaDDD
 #    $t0 ---> guarda temporariamente informacoes para impressao  
 #    $t1 ---> contador 
 #    $t2 ---> recebe o endereço da string nome4
 #    $t3 ---> usado para receber e enviar os valores de DDD nas funcoes de adicao e busca
 #    $t4 ---> usado para receber e enviar os valores de TELEFONE nas funcoes de adicao e busca
 #    $t5 ---> tamanho do vetor TIPO SANGUINEO
 #    $t7 --> auxiliar
 #    $t6 ---> usado para receber e enviar os valores de TIPO SANGUINEO nas funcoes de adicao e busca
 #    $t8 ---> valor da opcao digitada no menu incial
 #    $t9 ---> auxiliar de contador pessoas
 # _______________________________________________________________
 
.text
# Inicializacao
la $s0, nome1		#  indice do vetor NOME 1
la $s1, nome2		#  indice do vetor NOME 2
la $s6, nome3		#  indice do vetor NOME 3 
la $t2, nome4		#  indice do vetor NOME 4 
la $s2, ddd		# carrega $s4 com o endereco de memoria de ddd
la $s3, telefone	#   carrega $s3 com o endereco de memoria de TELEFONE
la $s4, tipo_sanguineo		#  carrega $s4 com o endereco de memoria de tipo sanguineo
li $t1, 4		#  iniciliza contador com 0	( a agenda armazena apenas 4 pessoas)
li $t9, 0
li $a3, 0		# contador de quantas pessoas já foram mostradas
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
j opMenu			# garante que vá retornar ao menu caso o usuário digite uma opcao inválida

# ---------- AGENDA LOTADA ----------
agendaLotada:
li $v0, 4
la $a0, agendaCheia
syscall
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
beq $t9, $t1, agendaLotada
addi $t9, $t9, 1
jal adicioneDoadoresNome
jal adicioneDoadoresDDD
jal adicioneDoadoresTelefone
jal adicioneDoadoresTipoSanguineo
j opMenu
# ---------- NOME - ADICIONE DOADORES ----------
adicioneDoadoresNome:
li $t8, 0
beq $a3, $t8 adicionaNome1
li $t8, 1
beq $a3, $t8 adicionaNome2
li $t8, 2
beq $a3, $t8 adicionaNome3
li $t8, 3
beq $a3, $t8 adicionaNome4
adicionaNome1:
	li $v0, 4                      
	la $a0, stringDigiteNome	#imprime Digite Nome
	syscall

	li $v0, 8
	la $a0, nome1		# le o nome digitado
	la $a1, 10			# le o tamanhho do nome
	syscall
	jr $ra
	
adicionaNome2:
	li $v0, 4                      
	la $a0, stringDigiteNome	#imprime Digite Nome
	syscall

	li $v0, 8
	la $a0, nome2			# le o nome digitado
	la $a1, 10			# le o tamanhho do nome
	syscall
	jr $ra
adicionaNome3:
	li $v0, 4                      
	la $a0, stringDigiteNome	#imprime Digite Nome
	syscall

	li $v0, 8
	la $a0, nome3			# le o nome digitado
	la $a1, 10			# le o tamanhho do nome
	syscall
	jr $ra
adicionaNome4:
	li $v0, 4                      
	la $a0, stringDigiteNome	#imprime Digite Nome
	syscall

	li $v0, 8
	la $a0, nome4			# le o nome digitado
	la $a1, 10			# le o tamanhho do nome
	syscall
	jr $ra

# ---------- DDD - ADICIONE DOADORES ----------
adicioneDoadoresDDD:
addi $a3, $a3, 1
li $v0, 4
la $a0, stringDigiteDDD
syscall

li $v0, 5
syscall
move $t3, $v0    	# passa o valor de v0 para t3

li $t7, 4
bge $t3, $t7 tratamentoDeErrosDDD
sw $t3, 0($s2)   	# passa o valor de t3 para o vetor ddd
addiu $s2, $s2, 4	# anda com o vetor ddd

jr $ra
# ---------- ADICIONA DDD - TRATAMENTO DE ERROS  ----------
tratamentoDeErrosDDD:
li $v0, 4
la $a0, opcaoInvalida
syscall
j adicioneDoadoresDDD
# ---------- TELEFONE - ADICIONE DOADORES ----------
adicioneDoadoresTelefone:

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
li $v0, 4
la $a0, stringDigiteTipoSanguineo
syscall

li $v0, 5
syscall                         # le o tipo sanguineo passado pelo usuario
move $t6, $v0                   # passa o valor de v0 para t1

li $t7, 8
bge $t6, $t7 tratamentoDeErrosTelefone
sw $t6, 0($s4) 			# passa o valor de t3 para o vetor tipo sanguineo
addiu $s4, $s4, 4		# anda com o vetor tipo sanguineo

jr $ra

# ---------- ADICIONA TIPO SANGUINEO - TRATAMENTO DE ERROS  ----------
tratamentoDeErrosTelefone:
li $v0, 4
la $a0, opcaoInvalida
syscall
j adicioneDoadoresTipoSanguineo
# ---------- MOSTRA DOADORES ----------
mostraDoadores:
# inicializacao pra mostrar doadores
li $a3, 0
la $s2, ddd
la $s3, telefone
la $s4, tipo_sanguineo

mostraDoadores1:
beq $a3, $t9 opMenu
li $t6, 0
beq $a3, $t6, mostraDoador1
li $t6, 1
beq $a3, $t6, mostraDoador2
li $t6, 2
beq $a3, $t6, mostraDoador3
li $t6, 3
beq $a3, $t6, mostraDoador4

# ---------- MOSTRA NOMES1 ----------
mostraDoador1:
li $v0, 4
la $a0, stringNome
syscall

li $v0, 4
la $a0, nome1
syscall
j mostraDados

mostraDoador2:
li $v0, 4
la $a0, stringNome
syscall
li $v0, 4
la $a0, nome2
syscall
j mostraDados

mostraDoador3:
li $v0, 4
la $a0, stringNome
syscall
li $v0, 4
la $a0, nome3
syscall
j mostraDados

mostraDoador4:
li $v0, 4
la $a0, stringNome
syscall
li $v0, 4
la $a0, nome4
syscall
j mostraDados


mostraDados:

# ---------- MOSTRA DDD ----------
li $v0, 4
la $a0, stringDDD
syscall

li $v0, 1
lw $a0, 0($s2)
syscall
addiu $s2, $s2, 4

# ---------- MOSTRA TELEFONE ----------
li $v0, 4
la $a0, stringTelefone
syscall

li $v0, 1
lw $a0, 0($s3)   	# passa o valor de t3 para o vetor ddd
syscall
addiu $s3, $s3, 4

# ---------- MOSTRA TIPO SANGUINEO ----------
li $v0, 4
la $a0, stringTipoSanguineo
syscall

li $v0, 1
lw $a0, 0($s4)   		# passa o valor de t3 para o vetor ddd
syscall
addi $s4, $s4, 4

addi $a3, $a3, 1

j mostraDoadores1
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
li $s7, 0
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
beq $s7, $t9, naoAchouDDD	# se percorrer o loop até o final OK // t9 guarda quantas pessoas estao na agenda
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
