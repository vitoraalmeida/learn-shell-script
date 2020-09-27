#!/bin/bash

# gera uma senha aleatória
# o usuário pode definir o tamanho da senha com -l e adicionar um caractere
# especial com -s
# modo verboso com -v

usage() {
    echo ;
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo ;
    echo 'Generate a random password.'
    echo ;
    echo '  -l LENGTH    Specify the password length.'
    echo '  -s           Append a special character to the password.'
    echo '  -v           Increase verbosity.'
    exit 1
}

log() {
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}" 
    fi
}

# define um tamanho padrão para a senha
LENGTH=48

while getopts vl:s OPTION
do
    case ${OPTION} in
        v)
            VERBOSE='true'
            log 'Verbose mode on.'
            ;;
        l)
            LENGTH="${OPTARG}"
            ;;
        s)
            USE_SPECIAL_CHAR='true'
            ;;
        ?)
            usage
            ;;
    esac
done

echo "Number of args: ${#}"
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"
# OPTIND é o numero de argumentos processados por getopts
# cada pedaço de texto separado por espaço será armazenado
# em argumentos posicionais
echo "OPTIND: ${OPTIND}"

# fazer o shift de OPTIND - 1 vai colocar o ultimo argumento como o primeiro
# $(( )) é para aritmética
shift "$(( OPTIND - 1))"

echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

# se tiver um argumento a mais, erro
if [[ "${#}" -gt 0 ]]
then
    usage
fi

log 'Generating a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

if [[ "${USE_SPECIAL_CHAR}" = 'true' ]]
then 
    log 'Selecting a random special character.'
    SPECIAL_CHAR=$(echo '!@#$%¨&*()_+=^' | fold -w1 | shuf | head -c1)
    PASSWORD="${PASSWORD}${SPECIAL_CHAR}"
fi

log 'Done'
log 'Here is the password:'

echo "${PASSWORD}"

exit 0
