#!/bin/bash

# Gera senhas aleatórias para cada usuario passado como argumento

# parametros posicionais: quando um comando é inserido, o bash
# agrega o comando executado e seus argumentos numa "lista" de parametros
# e o primeiro da lista é o caminho completo do comando que será executado.
# parametro != argumento. argumentos são passados na chamada (a partir de 1)
echo "${0}"
# echo "${1}" #primeiro argumento

# o bash procura os comandos na variável de ambiente PATH, que armazena
# caminhos para diversos executáveis, de forma sequencial.
echo "${PATH}"

# se este script for movido/copiado para uma localização no PATH, ele pode ser
# executado de qualquer lugar apenas pelo seu nome, mas a localização
# mostrada pelo comando abaixo será a completa.
echo "You executed this command: ${0}"
# para evitar sempre procurar pelo comando, o bash guarda um hash para o caminho
# do comando. para apagar as localizações armazenadas: hash -r

# 'basename' retorna apenas o nome do arquivo, sem os diretorios
# 'dirname' retorna apenas o nome do diretorio, sem o arquivo
echo "You used $(dirname "${0}") as the path to the $(basename "${0}") script"

# '#' armazena o numero de argumentos passados para o comando
NUMBER_OF_ARGUMENTS="${#}"
echo "You supplied ${NUMBER_OF_ARGUMENTS} argument(s) on the command line"

# certifica que pelo menos um argumento é passado
if [[ "${NUMBER_OF_ARGUMENTS}" -lt 1 ]]
then 
    echo "Usage: ${0} USER_NAME [USER_NAME]..."
    exit 1
fi

# '$@' e '$*' expandem para uma lista dos paramentros a partir do um
# '"$@"' expande para uma lista dos parametros posicionais a partir do 1
# '"$*"' expande para uma palavra apenas contendo cada paramentro a partir do 1 
# separados por espaço (ou outro caractere definido)
for USER_NAME in ${@} 
do
    PASSWORD=$(date +%s%N | sha256sum | head -c48)
    echo "${USER_NAME}: ${PASSWORD}"
done
