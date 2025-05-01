#!/bin/bash

# Получаем IP
IP=$(ip route get 1 | awk '{print $7}' | head -1)

# Получаем CIDR и маску через ipcalc
CIDR=$(ip -o -f inet addr show | grep "$IP" | awk '{print $4}' | cut -d '/' -f2)
MASK=$(ipcalc -nb "$IP/$CIDR" | grep "Netmask:" | awk '{print $2}')

# Шлюз
GATEWAY=$(ip route | grep default | awk '{print $3}' | head -1)