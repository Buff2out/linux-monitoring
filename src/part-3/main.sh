#!/bin/bash

# Проверка количества параметров
if [ $# -ne 4 ]; then
    echo "Error: Script requires exactly 4 numeric parameters (1-6)" >&2
    exit 1
fi

# Проверка допустимых значений (1-6)
for param in "$@"; do
    if ! [[ "$param" =~ ^[1-6]$ ]]; then
        echo "Error: All parameters must be numbers between 1 and 6" >&2
        exit 1
    fi
done

# Проверка: цвет текста не должен совпадать с цветом фона
if [ "$1" -eq "$2" ]; then
    echo "Error: Key background color and text color must not match" >&2
    exit 1
fi

if [ "$3" -eq "$4" ]; then
    echo "Error: Value background color and text color must not match" >&2
    exit 1
fi

# Цветовые коды
declare -A color_map=(
    [1]="37"  # white
    [2]="31"  # red
    [3]="32"  # green
    [4]="34"  # blue
    [5]="35"  # purple
    [6]="30"  # black
)

declare -A bg_map=(
    [1]="47"  # white
    [2]="41"  # red
    [3]="42"  # green
    [4]="44"  # blue
    [5]="45"  # purple
    [6]="40"  # black
)

key_text=${color_map[$2]}
key_bg=${bg_map[$1]}
value_text=${color_map[$4]}
value_bg=${bg_map[$3]}

key_style="\e[${key_text};${key_bg}m"
value_style="\e[${value_text};${value_bg}m"
reset="\e[0m"

source ./system_info.sh
source ./network_info.sh
source ./memory_info.sh
source ./disk_info.sh

echo -e "${key_style}HOSTNAME${reset} = ${value_style}$HOSTNAME${reset}"
echo -e "${key_style}TIMEZONE${reset} = ${value_style}$TIMEZONE${reset}"
echo -e "${key_style}USER${reset} = ${value_style}$USER${reset}"
echo -e "${key_style}OS${reset} = ${value_style}$OS${reset}"
echo -e "${key_style}DATE${reset} = ${value_style}$DATE${reset}"
echo -e "${key_style}UPTIME${reset} = ${value_style}$UPTIME${reset}"
echo -e "${key_style}UPTIME_SEC${reset} = ${value_style}$UPTIME_SEC${reset}"
echo -e "${key_style}IP${reset} = ${value_style}$IP${reset}"
echo -e "${key_style}MASK${reset} = ${value_style}$MASK${reset}"
echo -e "${key_style}GATEWAY${reset} = ${value_style}$GATEWAY${reset}"
echo -e "${key_style}RAM_TOTAL${reset} = ${value_style}$RAM_TOTAL GB${reset}"
echo -e "${key_style}RAM_USED${reset} = ${value_style}$RAM_USED GB${reset}"
echo -e "${key_style}RAM_FREE${reset} = ${value_style}$RAM_FREE GB${reset}"
echo -e "${key_style}SPACE_ROOT${reset} = ${value_style}$SPACE_ROOT MB${reset}"
echo -e "${key_style}SPACE_ROOT_USED${reset} = ${value_style}$SPACE_ROOT_USED MB${reset}"
echo -e "${key_style}SPACE_ROOT_FREE${reset} = ${value_style}$SPACE_ROOT_FREE MB${reset}"