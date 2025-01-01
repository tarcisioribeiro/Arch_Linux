#!/bin/bash

# Obtém o status da conexão de rede usando nmcli
network_status=$(nmcli -t -f ACTIVE,SSID dev wifi | grep ^yes | cut -d: -f2)

# Verifica se há uma rede conectada
if [ -z "$network_status" ]; then
    echo "No network"
else
    echo "$network_status"
fi

