#!/bin/bash
#
# Esta script cria um novo usuário no sistema local
# Você precisa fornecer um nome de usuário como argumento
# Opcionalmente, voce pode fornecer um comentario para a conta
# Uma senha será gerada automaticamente
# O usuário, senha e o host para a conta serão mostrados

# Certifica que o usuário precisa ter privilegios de super usuário
# >&2 envia o stdout para stderr
if [[ "${UID}" -ne 0 ]]
then
    echo "Por favor, execute o script com sudo ou como root" >&2
    exit 1
fi

# Certifica que serão passados argumentos para o script
if [[ "${#}" -eq 0 ]]
then
    echo "Uso: ${0} NOME_USUARIO [COMENTARIO]..." >&2
    exit 1
fi

# O primeiro parametro é o nome de usuário
USER_NAME="${1}"

# O nome não é mais necessário 
shift
COMMENT="${@}"

# Gera a senha
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# cria o usuário
# &> envia tanto stdout quanto stderr para o mesmo lugar
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

# verifica se houve erro na criação do usuário
if [[ "${?}" -ne 0 ]]
then
    echo "Algo de errado ocorreu e o usuário não foi criado" >&2
    exit 1
fi

echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

# verifica se a senha foi definida corretamente
if [[ "${?}" -ne 0 ]]
then
    echo "Algo de errado ocorreu e a senha não foi denifida" >&2
    exit 1
fi

# força a senha a ser trocada no primeiro login
passwd -e ${USER_NAME} &> /dev/null

# mostra os dados da conta
echo "Usuário: ${USER_NAME}"
echo "Senha: ${PASSWORD}"
echo "Host: ${HOSTNAME}"

exit 0

