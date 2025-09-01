#!/bin/bash

# Script para configurar automaticamente monitores do Hyprland
# Detecta monitores conectados e configura monitors.conf e autostart.conf dinamicamente

HYPR_CONFIG="$HOME/.config/hypr"
MONITORS_CONF="$HYPR_CONFIG/monitors.conf"
AUTOSTART_CONF="$HYPR_CONFIG/autostart.conf"

# Função para detectar monitores conectados
get_connected_monitors() {
    hyprctl monitors -j | jq -r '.[] | "\(.name):\(.width)x\(.height)@\(.refreshRate):\(.x),\(.y)"'
}

# Função para identificar a LG TV (DP-4 ou DP-5)
get_lg_tv_name() {
    hyprctl monitors -j | jq -r '.[] | select(.name | test("DP-[45]")) | .name' | head -1
}

# Backup dos arquivos originais
backup_configs() {
    [ ! -f "${MONITORS_CONF}.bak" ] && cp "$MONITORS_CONF" "${MONITORS_CONF}.bak" 2>/dev/null
    [ ! -f "${AUTOSTART_CONF}.bak" ] && cp "$AUTOSTART_CONF" "${AUTOSTART_CONF}.bak" 2>/dev/null
}

# Gerar novo monitors.conf
generate_monitors_conf() {
    local lg_tv_name="$1"
    
    cat > "$MONITORS_CONF" << EOF
monitor = eDP-1, 1920x1080@60, 4480x0, 1
monitor = HDMI-A-1, 2560x1080@75, 1920x0, 1
EOF

    # Adicionar configuração da LG TV se detectada
    if [ -n "$lg_tv_name" ]; then
        echo "monitor = $lg_tv_name, 1920x1080@60, 0x0, 1" >> "$MONITORS_CONF"
        
        # Comentar o monitor não usado
        if [ "$lg_tv_name" = "DP-4" ]; then
            echo "# monitor = DP-5, 1920x1080@60, 0x0, 1" >> "$MONITORS_CONF"
        else
            echo "# monitor = DP-4, 1920x1080@60, 0x0, 1" >> "$MONITORS_CONF"
        fi
    else
        echo "# monitor = DP-4, 1920x1080@60, 0x0, 1" >> "$MONITORS_CONF"
        echo "# monitor = DP-5, 1920x1080@60, 0x0, 1" >> "$MONITORS_CONF"
    fi
    
    echo "" >> "$MONITORS_CONF"
}

# Gerar novo autostart.conf
generate_autostart_conf() {
    local lg_tv_name="$1"
    
    cat > "$AUTOSTART_CONF" << EOF
# Extra autostart processes
# exec-once = uwsm app -- my-service

workspace = 1, monitor:HDMI-A-1
workspace = 2, monitor:eDP-1
EOF

    # Configurar workspace 3 baseado na LG TV detectada
    if [ -n "$lg_tv_name" ]; then
        echo "workspace = 3, monitor:$lg_tv_name" >> "$AUTOSTART_CONF"
        
        # Comentar o monitor não usado
        if [ "$lg_tv_name" = "DP-4" ]; then
            echo "# workspace = 3, monitor:DP-5" >> "$AUTOSTART_CONF"
        else
            echo "# workspace = 3, monitor:DP-4" >> "$AUTOSTART_CONF"
        fi
    else
        echo "# workspace = 3, monitor:DP-4" >> "$AUTOSTART_CONF"
        echo "# workspace = 3, monitor:DP-5" >> "$AUTOSTART_CONF"
    fi

    cat >> "$AUTOSTART_CONF" << EOF
workspace = 4, monitor:HDMI-A-1
workspace = 5, monitor:eDP-1


exec-once = "\$HOME/scripts/autostart.sh"
exec-once = "\$HOME/scripts/tmux_setup.sh"

EOF
}

# Função principal
main() {
    echo "🖥️  Detectando monitores conectados..."
    
    # Verificar se o Hyprland está rodando
    if ! hyprctl version &>/dev/null; then
        echo "❌ Hyprland não está rodando. Execute este script após iniciar o Hyprland."
        exit 1
    fi
    
    # Detectar LG TV
    lg_tv_name=$(get_lg_tv_name)
    
    if [ -n "$lg_tv_name" ]; then
        echo "📺 LG TV detectada como: $lg_tv_name"
    else
        echo "📺 LG TV não detectada (DP-4/DP-5 não conectados)"
    fi
    
    # Fazer backup dos arquivos
    backup_configs
    
    # Gerar novas configurações
    echo "⚙️  Gerando configurações..."
    generate_monitors_conf "$lg_tv_name"
    generate_autostart_conf "$lg_tv_name"
    
    echo "✅ Configurações atualizadas!"
    echo "📄 monitors.conf: $MONITORS_CONF"
    echo "📄 autostart.conf: $AUTOSTART_CONF"
    
    # Mostrar monitores detectados
    echo ""
    echo "🖥️  Monitores conectados:"
    hyprctl monitors | grep -E "Monitor|at"
    
    echo ""
    echo "🔄 Para aplicar as mudanças, recarregue o Hyprland com: hyprctl reload"
}

# Executar se chamado diretamente
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    main "$@"
fi