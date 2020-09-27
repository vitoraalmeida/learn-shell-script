# Para ser executado, é necessário que se altere as permissões do arquivo
# 4 = read, 2 = write, 1 = execute. 7 = rwx, 5 = rx
# o primeiro numero é referente ao owner, o segundo ao group e o ultimo others 
#$ chmod 755 create-local-user


#shebang - define qual será o interpretador que executara o script. se não for 
#          definido, será usado o shell que está sendo usado no momento
#!/bin/bash

#Informações que descrevem o script
#Esse script mostra diversas informações na tela

#echo é um comando buitin do shell, não requer programas externos, que envia
#argumentos para a saida padrão (stdout)
#para verificar a origem de um comando (builtin ou externo):
#$ type [comando]  ou $ type -a [comando]  (para mostras todas as origens)
echo 'Hello'

#declaração de variavel de texto. usa ' ou "
#convencionalmente usa-se sempre palavras em maiúsculo para variáveis
#Só pode iniciar com _ e letras. Só podem conter _, letras e numeros
WORD='script'

#para acessar o valor da variavel, deve-se usar o sinal de dolar($)
#Aspas simples imprimem o conteudo exatamente como está escrito, impede a
#expansão das variaveis. Para acessar o valor de variavies usar aspas duplas
echo "$WORD"

#vai imprimir $WORD na tela
echo '$WORD'

# combina variavies com textos hard-coded
echo "This is a shell $WORD"
echo "This is a shell ${WORD}" #mesmo efeito

#Para concatenar texto exatamente apos o valor da variavel, tem que se usar {}
echo "${WORD}ing is fun!"

ENDING='ed'
echo "This is ${WORD}${ENDING}"

#Reatribui um valor a uma variavel
ENDING='ing'
echo "This is ${WORD}${ENDING}"

