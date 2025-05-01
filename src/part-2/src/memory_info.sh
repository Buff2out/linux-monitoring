#!/bin/bash

# Получение данных в байтах
TOTAL_B=$(free -b | grep Mem | awk '{print $2}')
USED_B=$(free -b | grep Mem | awk '{print $3}')
FREE_B=$(free -b | grep Mem | awk '{print $4}')

RAM_TOTAL=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $2/(1024. * 1024.)}')
RAM_USED=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $3/(1024. * 1024.)}')
RAM_FREE=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $4/(1024. * 1024.)}')