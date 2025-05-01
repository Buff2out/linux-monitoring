#!/bin/bash

# Проверка на отсутствие параметров
if [ $# -ne 0 ]; then
    echo "Error: Script does not accept parameters" >&2
    exit 1
fi

# Импорт функций из модулей
# source (или аналог .) выполняет скрипт в текущем процессе, а не в дочернем. Это нужно чтобы:
#     Переменные из system_info.sh и других файлов стали доступны в main.sh
#     Не создавать лишних процессов
#     Без source переменные бы не сохранились!

source ./system_info.sh
source ./network_info.sh
source ./memory_info.sh
source ./disk_info.sh

# Вывод информации
echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL GB"
echo "RAM_USED = $RAM_USED GB"
echo "RAM_FREE = $RAM_FREE GB"
echo "SPACE_ROOT = $SPACE_ROOT MB"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED MB"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE MB"

# Запрос на сохранение
read -p "Save to file? (Y/N): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    filename=$(date +"%d_%m_%y_%H_%M_%S").status
    {
        echo "HOSTNAME = $HOSTNAME"
        echo "TIMEZONE = $TIMEZONE"
        echo "USER = $USER"
        echo "OS = $OS"
        echo "DATE = $DATE"
        echo "UPTIME = $UPTIME"
        echo "UPTIME_SEC = $UPTIME_SEC"
        echo "IP = $IP"
        echo "MASK = $MASK"
        echo "GATEWAY = $GATEWAY"
        echo "RAM_TOTAL = $RAM_TOTAL GB"
        echo "RAM_USED = $RAM_USED GB"
        echo "RAM_FREE = $RAM_FREE GB"
        echo "SPACE_ROOT = $SPACE_ROOT MB"
        echo "SPACE_ROOT_USED = $SPACE_ROOT_USED MB"
        echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE MB"
    } > "$filename"
    echo "File saved: $filename"
else
    echo "Data not saved."
fi