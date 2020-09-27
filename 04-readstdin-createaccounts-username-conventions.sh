#!/bin/bash

# This script creates an account on the local system.
# You will be prompted for the account name and password

# Ask for the user name
read -p 'Enter the username to create: ' USER_NAME
# Ask for the real name
read -p 'Enter the name of the person who this account is for: ' COMMENT
# Ask for the password
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user
# ${COMMENT} entre "" pois quando for expandido, se tiver espacos, hifens, serão
# mantidos. -c adiciona um comentario no arquivo de users, -m cria home
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user
#--stdin recebe o argumento pelo stdin e pipe (|) direciona a saida do comando
#anterior para stdin
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login
# -e = expire
passwd -e ${USER_NAME}
