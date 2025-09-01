#!/usr/bin/bash

# Script de instalação seletiva para Arch Linux Setup
# Permite escolher quais componentes instalar

set -e

# Cores para mensagens
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para exibir mensagens coloridas
msg_color() {
    echo -e "${2}${1}${NC}"
}

# Função para exibir cabeçalho
show_header() {
    clear
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                  ARCH LINUX SETUP                        ║"
    echo "║               Instalação Personalizada                   ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}\n"
}

# Função para mostrar menu
show_menu() {
    echo -e "${GREEN}Selecione os componentes que deseja instalar:${NC}\n"
    echo "1) 📦 Configuração Base (ZSH, Tmux, Fontes, Tema Dracula)"
    echo "2) 🚀 Aplicações Essenciais (VS Code, Chrome, Steam, etc.)"
    echo "3) 🤖 Ferramentas Avançadas (Ollama, Docker, Open WebUI)"
    echo "4) 🎨 Apenas Tema Dracula"
    echo "5) ⚡ Instalação Completa (Todos os componentes)"
    echo "6) 🔧 Configurações Personalizadas"
    echo -e "\n0) ❌ Sair"
    echo -e "\n${YELLOW}Digite os números separados por espaço (ex: 1 2 3):${NC}"
}

# Verificar pré-requisitos
check_prerequisites() {
    msg_color "Verificando pré-requisitos..." "$BLUE"
    
    # Verificar se é Arch Linux
    if [[ ! -f /etc/arch-release ]]; then
        msg_color "ERRO: Este script é apenas para Arch Linux!" "$RED"
        exit 1
    fi
    
    # Verificar conexão com internet
    if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        msg_color "ERRO: Sem conexão com a internet!" "$RED"
        exit 1
    fi
    
    # Verificar se o diretório do projeto existe
    if [[ ! -d "$HOME/Development/Arch_Linux" ]]; then
        msg_color "ERRO: Diretório do projeto não encontrado em $HOME/Development/Arch_Linux" "$RED"
        exit 1
    fi
    
    msg_color "✓ Pré-requisitos atendidos!" "$GREEN"
}

# Executar instalação base
install_base() {
    msg_color "🔧 Instalando configuração base..." "$BLUE"
    if [[ -f "./installation_1.sh" ]]; then
        chmod +x ./installation_1.sh
        ./installation_1.sh
        msg_color "✓ Configuração base instalada!" "$GREEN"
    else
        msg_color "ERRO: installation_1.sh não encontrado!" "$RED"
        return 1
    fi
}

# Executar instalação de aplicações
install_apps() {
    msg_color "📱 Instalando aplicações..." "$BLUE"
    if [[ -f "./installation_2.sh" ]]; then
        chmod +x ./installation_2.sh
        ./installation_2.sh
        msg_color "✓ Aplicações instaladas!" "$GREEN"
    else
        msg_color "ERRO: installation_2.sh não encontrado!" "$RED"
        return 1
    fi
}

# Executar instalação avançada
install_advanced() {
    msg_color "🚀 Instalando ferramentas avançadas..." "$BLUE"
    if [[ -f "./installation_3.sh" ]]; then
        chmod +x ./installation_3.sh
        ./installation_3.sh
        msg_color "✓ Ferramentas avançadas instaladas!" "$GREEN"
    else
        msg_color "ERRO: installation_3.sh não encontrado!" "$RED"
        return 1
    fi
}

# Instalar apenas tema Dracula
install_theme_only() {
    msg_color "🎨 Instalando apenas o tema Dracula..." "$BLUE"
    
    # Instalar tema GTK Dracula
    cd "$HOME/Downloads/" || exit
    if [[ ! -d "$HOME/.themes/Dracula" ]]; then
        wget -q https://github.com/dracula/gtk/archive/master.zip
        unzip -q master.zip
        mv gtk-master Dracula
        mv Dracula "$HOME/.themes"
        rm -f master.zip
    fi
    
    # Instalar ícones Dracula
    if [[ ! -d "$HOME/.local/share/icons/Tela-dracula" ]]; then
        git clone https://github.com/vinceliuice/Tela-icon-theme.git
        cd Tela-icon-theme || exit
        ./install.sh -n dracula
        cd .. && rm -rf Tela-icon-theme
    fi
    
    msg_color "✓ Tema Dracula instalado!" "$GREEN"
}

# Menu de configurações personalizadas
custom_config_menu() {
    while true; do
        clear
        show_header
        echo -e "${GREEN}Configurações Personalizadas:${NC}\n"
        echo "1) Apenas ZSH + Oh My Posh"
        echo "2) Apenas Tmux"
        echo "3) Apenas Fontes"
        echo "4) Apenas Stow configs"
        echo "5) Apenas Flatpak apps"
        echo "6) Apenas AUR packages"
        echo -e "\n0) Voltar ao menu principal"
        
        echo -ne "\n${YELLOW}Escolha uma opção: ${NC}"
        read -r choice
        
        case $choice in
            1) install_zsh_only ;;
            2) install_tmux_only ;;
            3) install_fonts_only ;;
            4) install_stow_configs ;;
            5) install_flatpak_only ;;
            6) install_aur_only ;;
            0) break ;;
            *) msg_color "Opção inválida!" "$RED"; sleep 2 ;;
        esac
    done
}

# Instalação completa
install_complete() {
    msg_color "🚀 Iniciando instalação completa..." "$BLUE"
    install_base
    install_apps  
    install_advanced
    msg_color "🎉 Instalação completa finalizada!" "$GREEN"
}

# Menu principal
main_menu() {
    cd "$HOME/Development/Arch_Linux" || exit 1
    
    while true; do
        show_header
        show_menu
        
        echo -ne "\n${YELLOW}Sua escolha: ${NC}"
        read -r choices
        
        if [[ "$choices" == "0" ]]; then
            msg_color "Saindo..." "$BLUE"
            exit 0
        fi
        
        # Processar múltiplas escolhas
        for choice in $choices; do
            case $choice in
                1) install_base ;;
                2) install_apps ;;
                3) install_advanced ;;
                4) install_theme_only ;;
                5) install_complete ;;
                6) custom_config_menu ;;
                *) msg_color "Opção inválida: $choice" "$RED" ;;
            esac
        done
        
        echo -e "\n${GREEN}Pressione Enter para continuar...${NC}"
        read -r
    done
}

# Funções para instalações personalizadas
install_zsh_only() {
    msg_color "Instalando apenas ZSH..." "$BLUE"
    sudo pacman -S zsh --needed --noconfirm
    cd packages && ./oh_my_zsh_install.sh
    msg_color "✓ ZSH instalado!" "$GREEN"
}

install_tmux_only() {
    msg_color "Instalando apenas Tmux..." "$BLUE"
    sudo pacman -S tmux --needed --noconfirm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || true
    ln -sf "$PWD/customization/tmux/.tmux.conf" "$HOME/.tmux.conf"
    msg_color "✓ Tmux instalado!" "$GREEN"
}

install_fonts_only() {
    msg_color "Instalando apenas fontes..." "$BLUE"
    sudo mkdir -p /usr/share/fonts
    sudo cp fonts/*.ttf /usr/share/fonts/
    fc-cache -fv
    msg_color "✓ Fontes instaladas!" "$GREEN"
}

install_stow_configs() {
    msg_color "Aplicando configurações Stow..." "$BLUE"
    cd stow || exit
    for config in */; do
        if [[ -d "$config" ]]; then
            stow -v -t "$HOME/.config/$config" "$config"
        fi
    done
    msg_color "✓ Configurações aplicadas!" "$GREEN"
}

install_flatpak_only() {
    msg_color "Instalando apenas apps Flatpak..." "$BLUE"
    flatpak install flathub com.getpostman.Postman -y
    flatpak install flathub org.telegram.desktop -y
    msg_color "✓ Apps Flatpak instalados!" "$GREEN"
}

install_aur_only() {
    msg_color "Instalando apenas packages AUR..." "$BLUE"
    if command_exists yay; then
        yay -S visual-studio-code-bin --noconfirm
        yay -S github-desktop --noconfirm
    else
        msg_color "ERRO: yay não está instalado!" "$RED"
    fi
    msg_color "✓ Packages AUR instalados!" "$GREEN"
}

# Função para verificar se comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Início do script
main() {
    check_prerequisites
    main_menu
}

# Executar apenas se for chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi