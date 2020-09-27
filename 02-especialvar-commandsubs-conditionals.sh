#!/bin/bash

# Display the UID and username of the user executing this script
# Display if the user is the root user or not

# Display the UID
# UID é uma variável definida pelo sistema, quando o shell inicia. readonly
echo "Your UID is ${UID}"

# Display the username 
# $ id -un          -> mostra o nome do usuario
USER_NAME=$(id -un) #retorna o resultado do comando
#USER_NAME=`id -un` ---> a mesma coisa 
echo "Your username is ${USER_NAME}"

# Display if the user is the root user or not
if [[ "${UID}" -eq 0 ]] #[[ ]] é especifico do bash
then
    echo 'You are root'
else
    echo 'You are not root'
fi

#operadores aritméticos
#-eq/ne     ->  igual(equal)/diferente(not equal)
#-gt/-lt    ->  maior que/ menor que 
#-ge/-le    ->  maior ou igual/menor ou igual     

#logicos
#EXPR1 -a EXPR2 -> verdade se as duas expressões forem verdadeiras
#EXPR1 -o EXPR2 -> verdade se alguma das expressões forem verdadeiras
## ! EXPR       -> verdade se a expressão for falsa
