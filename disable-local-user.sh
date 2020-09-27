#!/bin/bash
#
# O script desabilita, deleta, e/ou arquiva usuários na máquina local
#

ARCHIVE_DIR='/archive'

usage() {
    # Mostra como usar o script
    echo "Usage: ${0} [-dra] USER [USERNAME]..." >&2
    echo 'Disable a local Linux account.' >&2
    echo '  -d  Deletes accounts instead of disabling them'. >&2
    echo '  -r  Removes the home directory associated with the account(s).' >&2
    echo '  -a  Creates an archive of the home directory associated with the account(s).' >&2
    exit 1
}

# Certifica que o usuário precisa ter privilégio de super usuário
if [[ "${UID}" -ne 0 ]]
then
    echo "Você precisa ser root ou executar o script com sudo"
    exit 1
fi

# Faz o parsing das opções
while getopts dra OPTION
do
    case ${OPTION} in
        d) DELETE_USER='true' ;;
        r) REMOVE_OPTION='-r' ;;
        a) ARCHIVE='true' ;;
        ?) usage ;;
    esac
done

# Remove as opções deixando os argumentos restantes
shift "$(( OPTIND - 1))"

# Se o usuário não fornecer ao menos um usuário, mostra como usar
if [[ "${#}" -lt 1 ]]
then 
    usage
fi

# Percorre todos os nomes de usuário fornecidos como argumento
for USERNAME in "${@}"
do
    echo "Processando usuario: ${USERNAME}"

    # Contas de usuarios normais geralmente sao criadas com UID >= 1000
    USERID=$(id -u ${USERNAME})
    if [[ "${USERID}" -lt 1000 ]]
    then
        echo "A tentativa de remover o usuario ${USERNAME} com UID ${USERID} foi recusada." >&2
        exit 1
    fi

    # Arquiva os dados do diretorio home do usuario se a opcao for usada
    if [[ "${ARCHIVE}" = 'true' ]]
    then
        # cria o diretorio se nao existir
        if [[ ! -d "${ARCHIVE_DIR}" ]]
        then
            echo "Criando o diretorio ${ARCHIVE_DIR}."
            mkdir -p ${ARCHIVE_DIR}
            #verifica se a criacao foi bem sucedida
            if [[ "${?}" -ne 0 ]]
            then 
                echo "O diretorio de arquivo ${ARCHIVE_DIR} nao foi criado." >&2
                exit 1
            fi
        fi

        HOME_DIR="/home/${USERNAME}"
        ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
        # se o diretorio home do usuario existir, arquiva
        if [[ -d "${HOME_DIR}" ]]
        then
            echo "Arquivando ${HOME_DIR} em ${ARCHIVE_FILE}"
            tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
            # Verifica se o comando tar foi bem sucedido
            if [[ "${?}" -ne 0 ]]
            then
                echo "Não foi possivel criar ${ARCHIVE_FILE}." >&2
                exit 1
            fi
        else
            echo "${HOME_DIR} não existe ou nao eh um diretorio." >&2
            exit 1
        fi
    fi

    # Se a opção de remover for escolhida, remove
    if [[ "${DELETE_USER}" = 'true' ]]
    then

        userdel ${REMOVE_OPTION} ${USERNAME}

        # Checa se o usuário foi realmente deletado
        if [[ "${?}" -ne 0 ]]
        then
            echo "A conta ${USERNAME} NAO foi deletada." >&2
            exit 1
        fi
        echo "A conta ${USERNAME} foi deletada." 
    else
        # Apenas desabilita 
        chage -E 0 ${USERNAME}

        # Checa se o usuário foi realmente desabilitado
        if [[ "${?}" -ne 0 ]]
        then
            echo "A conta ${USERNAME} NAO foi desabilitada." >&2
            exit 1
        fi
        echo "A conta ${USERNAME} foi desabilitada." 
    fi
done

exit 0
