#!/bin/bash

# awk '{print $3, $4}'
#     awk - текстовая утилита для обработки колонок
#     Выводит 3-е и 4-е слово из строки
#     Пример: для строки Time zone: Europe/Moscow (MSK, +0300) выведет Europe/Moscow (MSK,

HOSTNAME=$(uname -nmr)
TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3}')
USER=$(whoami)
OS=$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f2)
DATE=$(date +"%d %b %Y %H:%M:%S")
UPTIME=$(uptime -p | sed 's/up //')
UPTIME_SEC=$(awk '{print $1}' /proc/uptime)