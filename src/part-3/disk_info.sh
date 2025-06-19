#!/bin/bash

# Получение данных в байтах
ROOT_TOTAL_B=$(df -B1 / | awk 'NR==2 {print $2}')
ROOT_USED_B=$(df -B1 / | awk 'NR==2 {print $3}')
ROOT_FREE_B=$(df -B1 / | awk 'NR==2 {print $4}')

SPACE_ROOT=$(df / | grep dev | awk '{printf "%.2f MB", $2/(1024.)}')
SPACE_ROOT_USED=$(df / | grep dev | awk '{printf "%.2f MB", $3/(1024.)}')
SPACE_ROOT_FREE=$(df / | grep dev | awk '{printf "%.2f MB", $4/(1024.)}')
