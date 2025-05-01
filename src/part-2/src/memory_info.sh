#!/bin/bash

# Получение данных в байтах
TOTAL_B=$(free -b | grep Mem | awk '{print $2}')
USED_B=$(free -b | grep Mem | awk '{print $3}')
FREE_B=$(free -b | grep Mem | awk '{print $4}')

# Конвертация в GB с точностью до 3 знаков
# RAM_TOTAL=$(echo "scale=3; $TOTAL_B / 1073741824" | bc -l | xargs printf "%.3f")
# RAM_USED=$(echo "scale=3; $USED_B / 1073741824" | bc -l | xargs printf "%.3f")
# RAM_FREE=$(echo "scale=3; $FREE_B / 1073741824" | bc -l | xargs printf "%.3f")

RAM_TOTAL=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $2/(1024. * 1024.)}')
RAM_USED=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $3/(1024. * 1024.)}')
RAM_FREE=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $4/(1024. * 1024.)}')