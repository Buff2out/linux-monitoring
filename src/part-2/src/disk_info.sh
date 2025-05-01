#!/bin/bash

# Получение данных в байтах
ROOT_TOTAL_B=$(df -B1 / | awk 'NR==2 {print $2}')
ROOT_USED_B=$(df -B1 / | awk 'NR==2 {print $3}')
ROOT_FREE_B=$(df -B1 / | awk 'NR==2 {print $4}')

# Конвертация в MB с точностью до 2 знаков
# SPACE_ROOT=$(echo "scale=2; $ROOT_TOTAL_B / 1048576" | bc -l | xargs printf "%.2f")
# SPACE_ROOT_USED=$(echo "scale=2; $ROOT_USED_B / 1048576" | bc -l | xargs printf "%.2f")
# SPACE_ROOT_FREE=$(echo "scale=2; $ROOT_FREE_B / 1048576" | bc -l | xargs printf "%.2f")

SPACE_ROOT=$(df / | grep dev | awk '{printf "%.2f MB", $2/(1024.)}')
SPACE_ROOT_USED=$(df / | grep dev | awk '{printf "%.2f MB", $3/(1024.)}')
SPACE_ROOT_FREE=$(df / | grep dev | awk '{printf "%.2f MB", $4/(1024.)}')
