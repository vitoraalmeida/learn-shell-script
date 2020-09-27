#!/bin/bash

# Display the UID and username of the user executing this script
# Display if the user is the vagrant user or not

# Display the UID
echo "Your UID is ${UID}"

# Only display if the UID does NOT match 1000
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "$UID_TO_TEST_FOR" ]]
then
    echo "Your UID does not match ${UID_TO_TEST_FOR}."
    exit 1 # status de que não foi bem sucedido
fi

# Display the username
USER_NAME=$(id -nu)

# Test if the command succeeded
if [[ "${?}" -ne 0 ]] # ? é a variavel que guarda o status do ultimo comando
then
    echo 'The id command did not execute successfully.'
    exit 1
fi

echo "You username is ${USER_NAME}."

# You can usa a string test conditional
USER_NAME_TO_TEST_FOR='vagrant'
#pattern match. = dentro de [[ é comparação.
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi

# Test for != (not equal) for the string
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your user name doesn't match ${USER_NAME_TO_TEST_FOR}. "
    exit 1
fi

exit 0
