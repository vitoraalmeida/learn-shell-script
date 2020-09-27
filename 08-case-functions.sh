#!/bin/bash

# demonstra a instrução case

#if [[ "${1}" = 'start' ]]
#then
#    echo 'Starting'
#elif [[ "${1}" = 'stop' ]]
#then 
#    echo 'stop'
#elif [[ "${1}" = 'status' ]]
#then
#    echo 'status'
#else
#    exit 1
#fi

# case funciona com pattern matching. Qualquer caractere que aparece num padrão,
# exceto carateres especiais de padrão, casam com si mesmos
# '*' casa com qualquer coisa
# '?' casa com um único caractere
# [...] casa com os caracteres dentro dos colchetes
case "${1}" in
    start) echo 'Starting' ;; # ;;finaliza um bloco de código
    stop) echo 'Stopping' ;;
    status | state | --status | --state) echo 'Status' ;;
    *)
        echo 'Supply a valid option' >&2 #redireciona para stderr
        exit 1
        ;;
esac

# essa função manda uma mensagem para syslog e para stdout se VERBOSE for true
log() { #definição de função
    # variaveis com local são acessiveis apenas na função
    # variaveis locais são indicadas, porque variaveis locais podem ser modificadas
    # por funções e pode alterar o funcionamento de outros locais que a usam
    #local VERBOSE="${1}"
    #shift
    #'@' é um caractere special que expande para todos os parametros posicionais
    # a partir do 1. Usando local, os parametros usados serão os passados para a função
    local MESSAGE="${@}" 
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}" 
    fi

    # logger escreve a mensagem passada no arquivo /var/log/messages
    # a mensagem aparecerá com a data e hora, nome do host e usuário
    # se alguma tag for passada (-t), ao inves do usuaŕio, mostra a tag
    logger -t 08-case-functions.sh "${MESSAGE}"
}

backup_file() {
    # essa função cria um arquivo de backup. retorna um status diferente de 0
    # para erros

    local FILE="${1}"

    # -f verifica se o arquivo existe
    if [[ -f "${FILE}" ]]
    then 
        # /var/tmp demora mais tempo para ser limpo
        local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        log "Backing up ${FILE} to ${BACKUP_FILE}."
        # -p = preserva as permissões do arquivo, timestamp, mode
        cp -p ${FILE} ${BACKUP_FILE}
    else
        return 1 #return é para funções
    fi
}

# não pode ser modificada
readonly VERBOSE='true' 
log 'hello' # chamada de função
log 'is there anybody in there' # chamada de função

backup_file '/etc/passwd'

if [[ "${?}" -eq '0' ]]
then
    log 'File backup succeded!'
else
    log 'File backup failed!'
    exit 1
fi

exit 0
