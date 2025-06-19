#!/bin/bash

# Проверка на наличие параметров
if [ $# -ne 0 ]; then
    echo "Error: Script does not accept command line parameters" >&2
    exit 1
fi

# Проверка наличия конфигурационного файла
CONFIG_FILE="config.cfg"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file '$CONFIG_FILE' not found" >&2
    exit 1
fi

# Цвета по умолчанию (если не указаны в конфиге)
DEFAULT_COLUMN1_BG=6   # black
DEFAULT_COLUMN1_FC=1   # white
DEFAULT_COLUMN2_BG=2   # red
DEFAULT_COLUMN2_FC=4   # blue

# Чтение конфига
source "$CONFIG_FILE"

# Проверка допустимых значений (1-6)
validate_color() {
    local name="$1"
    local value="$2"
    if ! [[ "$value" =~ ^[1-6]$ ]]; then
        echo "Error: $name must be a number between 1 and 6" >&2
        exit 1
    fi
}

# Применение дефолтных значений, если не заданы
column1_background=${column1_background:-$DEFAULT_COLUMN1_BG}
column1_font_color=${column1_font_color:-$DEFAULT_COLUMN1_FC}
column2_background=${column2_background:-$DEFAULT_COLUMN2_BG}
column2_font_color=${column2_font_color:-$DEFAULT_COLUMN2_FC}

# Проверка допустимых значений
validate_color "column1_background" "$column1_background"
validate_color "column1_font_color" "$column1_font_color"
validate_color "column2_background" "$column2_background"
validate_color "column2_font_color" "$column2_font_color"

# Проверка: цвет текста не должен совпадать с цветом фона
if [ "$column1_background" -eq "$column1_font_color" ]; then
    echo "Error: Column 1 background and font color must not match" >&2
    exit 1
fi

if [ "$column2_background" -eq "$column2_font_color" ]; then
    echo "Error: Column 2 background and font color must not match" >&2
    exit 1
fi

# Цветовые карты
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

# Получаем ANSI-коды
key_style="\e[${color_map[$column1_font_color]};${bg_map[$column1_background]}m"
value_style="\e[${color_map[$column2_font_color]};${bg_map[$column2_background]}m"
reset="\e[0m"

# Импорт информации из модулей
source ./system_info.sh
source ./network_info.sh
source ./memory_info.sh
source ./disk_info.sh

# Вывод информации с цветами
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

# Функция для вывода цветов с пометкой default, если они взяты из дефолта
print_color() {
    local name="$1"
    local value="$2"
    local default="$3"
    local color_name

    case "$value" in
        1) color_name="white" ;;
        2) color_name="red" ;;
        3) color_name="green" ;;
        4) color_name="blue" ;;
        5) color_name="purple" ;;
        6) color_name="black" ;;
    esac

    if [ "$value" -eq "$default" ]; then
        echo "$name = default ($color_name)"
    else
        echo "$name = $value ($color_name)"
    fi
}

# Вывод цветовой схемы
echo
print_color "Column 1 background" "$column1_background" "$DEFAULT_COLUMN1_BG"
print_color "Column 1 font color" "$column1_font_color" "$DEFAULT_COLUMN1_FC"
print_color "Column 2 background" "$column2_background" "$DEFAULT_COLUMN2_BG"
print_color "Column 2 font color" "$column2_font_color" "$DEFAULT_COLUMN2_FC"