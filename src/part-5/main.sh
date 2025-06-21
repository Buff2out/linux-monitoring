#!/bin/bash

# Проверка на количество параметров
if [ $# -ne 1 ]; then
    echo "Error: Missing directory path parameter" >&2
    exit 1
fi

DIR_PATH="$1"

# Проверка на наличие завершающего слэша
if [[ ! "$DIR_PATH" =~ /$ ]]; then
    echo "Error: Path must end with '/'" >&2
    exit 1
fi

# Проверка существования директории
if [ ! -d "$DIR_PATH" ]; then
    echo "Error: Directory does not exist" >&2
    exit 1
fi

# Замер времени выполнения
start_time=$(date +%s)

# 1. Общее число папок, включая вложенные
TOTAL_FOLDERS=$(find "$DIR_PATH" -type d | wc -l)

# 2. Топ-5 папок по размеру
TOP_FOLDERS=$(du -h "$DIR_PATH" --max-depth=1 2>/dev/null | sort -hr | head -n 6 | awk 'NR==1 {next} {sub(/\/$/, "", $2); print NR-1 " " $2 "/, " $1}')

# 3. Общее число файлов
TOTAL_FILES=$(find "$DIR_PATH" -type f | wc -l)

# 4. Количество файлов по категориям
CONF_FILES=$(find "$DIR_PATH" -type f -name "*.conf" | wc -l)
TEXT_FILES=$(find "$DIR_PATH" -type f -exec file {} \; | grep -i "text" | wc -l)
EXEC_FILES=$(find "$DIR_PATH" -type f -executable | wc -l)
LOG_FILES=$(find "$DIR_PATH" -type f -name "*.log" | wc -l)
ARCHIVE_FILES=$(find "$DIR_PATH" -type f $ -name "*.tar" -o -name "*.tar.gz" -o -name "*.zip" -o -name "*.rar" $ | wc -l)
SYMLINKS=$(find "$DIR_PATH" -type l | wc -l)

# 5. Топ-10 файлов по размеру
TOP_FILES=$(find "$DIR_PATH" -type f -printf "%s %p\n" 2>/dev/null | sort -nr | head -n 10 | awk '{split($2, a, "."); ext = (length(a) > 1 ? a[length(a)] : "unknown"); printf "%d - %s, %.2f MB, %s\n", NR, $2, $1/1024/1024, ext}')

# 6. Топ-10 исполняемых файлов по размеру + MD5
TOP_EXECUTABLES=$(find "$DIR_PATH" -type f -executable -printf "%s %p\n" 2>/dev/null | sort -nr | head -n 10 | awk '{cmd="md5sum "$2; cmd | getline hash; close(cmd); sub(/ .*/, "", hash); printf "%d - %s, %.2f MB, %s\n", NR, $2, $1/1024/1024, hash}')

# 7. Время выполнения
end_time=$(date +%s)
exec_time=$(awk -v start="$start_time" -v end="$end_time" 'BEGIN { printf "%.2f", end - start }')

# Вывод результата
echo "Total number of folders (including all nested ones) = $TOTAL_FOLDERS"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$TOP_FOLDERS"
echo "Total number of files = $TOTAL_FILES"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $CONF_FILES"
echo "Text files = $TEXT_FILES"
echo "Executable files = $EXEC_FILES"
echo "Log files (with the extension .log) = $LOG_FILES"
echo "Archive files = $ARCHIVE_FILES"
echo "Symbolic links = $SYMLINKS"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$TOP_FILES"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$TOP_EXECUTABLES"
echo "Script execution time (in seconds) = $exec_time"