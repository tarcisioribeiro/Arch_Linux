#!/bin/bash

# Script para configurar automaticamente IP com final .200 e iniciar VPN tarcisio
# Autor: Claude Code
# Data: $(date)

set -e

LOG_FILE="/tmp/network_config.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Iniciando configuração de rede..."

# Detectar interface de rede principal (excluindo loopback)
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)

if [ -z "$INTERFACE" ]; then
    log "ERRO: Não foi possível detectar a interface de rede principal"
    exit 1
fi

log "Interface detectada: $INTERFACE"

# Obter IP atual
CURRENT_IP=$(ip addr show "$INTERFACE" | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -1)

if [ -z "$CURRENT_IP" ]; then
    log "ERRO: Não foi possível obter o IP atual da interface $INTERFACE"
    exit 1
fi

log "IP atual: $CURRENT_IP"

# Extrair os três primeiros octetos do IP
IP_BASE=$(echo "$CURRENT_IP" | cut -d'.' -f1-3)
LAST_OCTET=$(echo "$CURRENT_IP" | cut -d'.' -f4)

log "Base do IP: $IP_BASE"
log "Último octeto atual: $LAST_OCTET"

# Verificar se já termina em .200
if [ "$LAST_OCTET" = "200" ]; then
    log "IP já está configurado com final .200, nenhuma alteração necessária"
else
    NEW_IP="${IP_BASE}.200"
    log "Configurando novo IP: $NEW_IP"
    
    # Obter máscara de rede atual
    NETMASK=$(ip addr show "$INTERFACE" | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f2 | head -1)
    
    if [ -z "$NETMASK" ]; then
        NETMASK="24"  # Padrão para redes /24
        log "Usando máscara padrão: /$NETMASK"
    else
        log "Máscara atual: /$NETMASK"
    fi
    
    # Obter gateway
    GATEWAY=$(ip route | grep default | grep "$INTERFACE" | awk '{print $3}' | head -1)
    
    if [ -z "$GATEWAY" ]; then
        log "AVISO: Gateway não detectado, usando ${IP_BASE}.1 como padrão"
        GATEWAY="${IP_BASE}.1"
    fi
    
    log "Gateway: $GATEWAY"
    
    # Remover configuração IP atual
    log "Removendo configuração IP atual..."
    sudo ip addr del "$CURRENT_IP/$NETMASK" dev "$INTERFACE" 2>/dev/null || true
    
    # Configurar novo IP
    log "Configurando novo IP..."
    sudo ip addr add "$NEW_IP/$NETMASK" dev "$INTERFACE"
    
    # Configurar rota padrão
    log "Configurando rota padrão..."
    sudo ip route del default 2>/dev/null || true
    sudo ip route add default via "$GATEWAY" dev "$INTERFACE"
    
    # Reiniciar interface de rede
    log "Reiniciando interface de rede..."
    sudo ip link set "$INTERFACE" down
    sleep 2
    sudo ip link set "$INTERFACE" up
    sleep 3
    
    log "IP alterado de $CURRENT_IP para $NEW_IP"
fi

# Iniciar VPN tarcisio
log "Iniciando VPN tarcisio..."

# Verificar se a VPN já está ativa
VPN_STATUS=$(nmcli connection show --active | grep "tarcisio" || echo "")

if [ -n "$VPN_STATUS" ]; then
    log "VPN tarcisio já está ativa"
else
    # Verificar se a conexão existe
    if nmcli connection show "tarcisio" >/dev/null 2>&1; then
        log "Conectando à VPN tarcisio..."
        nmcli connection up "tarcisio"
        
        # Verificar se a conexão foi bem-sucedida
        sleep 5
        VPN_CHECK=$(nmcli connection show --active | grep "tarcisio" || echo "")
        if [ -n "$VPN_CHECK" ]; then
            log "VPN tarcisio conectada com sucesso"
        else
            log "ERRO: Falha ao conectar à VPN tarcisio"
            exit 1
        fi
    else
        log "ERRO: Conexão VPN 'tarcisio' não encontrada"
        log "Conexões disponíveis:"
        nmcli connection show | tee -a "$LOG_FILE"
        exit 1
    fi
fi

log "Configuração de rede concluída com sucesso!"
log "Log salvo em: $LOG_FILE"

# Mostrar status final
log "Status final da rede:"
ip addr show "$INTERFACE" | grep 'inet ' | tee -a "$LOG_FILE"
nmcli connection show --active | grep -E "(NAME|tarcisio)" | tee -a "$LOG_FILE"