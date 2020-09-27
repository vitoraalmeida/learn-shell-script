#!/bin/bash

# Gera uma senha aleatória

#Cada vez que RANDOM é referenciado (atribuido a uma variável p/ ex)
#um numero aleatorio entre 0 e 32767 é gerado.
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

#date mostra ou define a data/hora do sistema
# quando passado '+' define um formato
# o formado é definido com '%'. '%s' são os segundos passados desde
# 1970-01-01 00:00:00 UTC (epoch).
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# %n é o nanosegundo em que o comando date foi executado
# assim os dois valores são concatenados
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# sha256sum sempre gera o mesmo numero hexadecimal para um mesmo conteudo 
# que foi passado como input. 
PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c32)
echo "${PASSWORD}"

#fold recebe uma linha de texto e, com a opção 'w', imprime uma quantidade de 
#caracteres por linha igual ao valor passado. depois passa para a proxima linha
#proxima linha e faz o mesmo até o fim do texto
SPECIAL_CHARACTER=$(echo "!@#$%*()_+&-=" | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c32)
echo "${PASSWORD}${SPECIAL_CHARACTER}"


