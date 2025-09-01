#!/bin/bash

# Configurar rede (IP .200 e VPN tarcisio)
sudo "$HOME/Development/Arch_Linux/scripts/network_config.sh" &

# Configurar monitores automaticamente no startup
"$HOME/scripts/configure_monitors.sh"

# Aguardar um pouco para garantir que os monitores estejam configurados
sleep 3

# Bloquear cursor do mouse durante startup
# hyprctl keyword cursor:no_hardware_cursors true
# hyprctl keyword cursor:hide_on_key_press true
# hyprctl keyword general:cursor_inactive_timeout 1
# notify-send "Sistema Iniciando" "Cursor oculto durante a inicialização dos aplicativos" -t 5000 -i system-run

# # Função para aguardar que uma aplicação seja aberta em um workspace
# wait_for_app() {
#     local workspace=$1
#     local app_name=$2
#     local max_attempts=30
#     local attempt=0
    
#     while [ $attempt -lt $max_attempts ]; do
#         if hyprctl clients | grep -q "$app_name"; then
#             # Verificar se a aplicação está no workspace correto
#             if hyprctl clients | grep -A 5 "$app_name" | grep -q "workspace: $workspace"; then
#                 return 0
#             fi
#         fi
#         sleep 1
#         attempt=$((attempt + 1))
#     done
#     return 1
}

# Abrir aplicações nos workspaces específicos
# Workspace 1: Visual Studio Code
# hyprctl dispatch workspace 1
# sleep 2
# code &
# wait_for_app 1 "code"
# sleep 2

# # Workspace 2: Chromium
# hyprctl dispatch workspace 2
# sleep 2
# chromium &
# wait_for_app 2 "chromium"
# sleep 2

# # Workspace 3: Spotify, Alacritty com cava e Alacritty com nvtop
# hyprctl dispatch workspace 3
# sleep 2
# spotify &
# sleep 3
# alacritty -e cava &
# sleep 2
# alacritty -e nvtop &
# wait_for_app 3 "spotify"
# sleep 2

# # Restaurar configurações do cursor
# hyprctl keyword cursor:no_hardware_cursors false
# hyprctl keyword cursor:hide_on_key_press false
# hyprctl keyword general:cursor_inactive_timeout 0
# notify-send "Sistema Pronto" "Todos os aplicativos foram abertos. Cursor restaurado." -t 3000 -i system-run

# Voltar para o workspace 1
hyprctl dispatch workspace 1
