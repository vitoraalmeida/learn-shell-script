#!/bin/bash

# Demonstra while loops

echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"

while [[ "${X}" -eq 1 ]]
do
    echo "This is the value of X: ${X}"
    X=7
done

# shift diminui o numero de positional parameters e redefine
# o argumento N para ser o N+1 ou N+m a depender do valor passado
while [[ "${#}" -gt 0 ]]
do
    echo "Number of parameters: ${#}"
    echo "Parameter 1: ${1}"
    echo "Parameter 2: ${2}"
    echo "Parameter 3: ${3}"
    echo
    shift 
done
    
