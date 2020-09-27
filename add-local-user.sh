#!/bin/bash

# Esse script cria um usuário numa maquina local.
# Será requisitado que o usuário insira um nome de usuário, o seu nome completo
# e senha.
# O nome de usuário, senha e host para a conta serão exibidos no fim.

# Certifica que o script será executado apenas com privilégios de super usuário
if [[ "${UID}" -ne 0 ]]
then
    echo "Por favor, execute o script com sudo ou como root"
    exit 1
fi

read -p 'Insira o nome de usuário para login: ' USERNAME
read -p 'Insira o nome completo do usuário: ' COMMENT
read -p 'Insira uma senha para o usuário: ' PASSWORD

useradd -c "${COMMENT}" -m ${USERNAME}

if [[ "${?}" -ne 0 ]]
then
    echo 'Não foi possível criar a conta'
    exit 1
fi

echo "${PASSWORD}" | passwd --stdin ${USERNAME}

if [[ "${?}" -ne 0 ]]
then
    echo 'Erro na definição da senha'
    exit 1
fi

# Forca o usuário a redefinar a senha no primeiro login
passwd -e ${USERNAME}

echo ;
echo "Usuário criado com sucesso"
echo ;
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"

exit 0
