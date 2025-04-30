#!/bin/bash

# $# — это специальная переменная в Bash, 
# которая содержит количество аргументов, 
# переданных скрипту при запуске.
# $@ — все аргументы в виде списка

if [[ "$#" -ne 1 ]] then
    echo "Err: only 1 parameter needed"
    exit 1
fi


if [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Err: typed number" >&2
    exit 1
else
    echo "$1"
fi