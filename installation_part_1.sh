#!/usr/bin/bash

# Script de instalação unificada para Arch Linux Setup
# Executa tudo sem necessidade de recarregar shell ou reiniciar

# Cores para mensagens
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variáveis globais
REPO_DIR="$HOME/Development/Arch_Linux"
TERMINALS_DIR="$REPO_DIR/packages"
CUSTOMIZATION_DIR="$REPO_DIR/customization"
BREW_INSTALLED=false

mkdir -p "$HOME/Downloads"
sudo pacman -Syu
sudo pacman -S git curl wget nano fastfetch vim vi neovim zip unzip github-cli
sudo pacman -S git curl fzf wget fastfetch btop htop ttf-dejavu noto-fonts \
	noto-fonts-emoji ttf-liberation gst-libav gst-plugins-bad gst-plugins-good \
	gst-plugins-ugly ffmpeg gstreamer hyrpland kitty xdg-desktop-portal \
	xdg-desktop-portal-hyprland zip unzip p7zip unrar tar gzip wofi thunar \
	xed flatpak python3 vlc obs-studio zsh tmux waybar

# Função para exibir mensagens coloridas
msg_color() {
    echo -e "${2}${1}${NC}"
    sleep 1
}

# Função para exibir cabeçalho
show_header() {
    clear
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                  ARCH LINUX SETUP                         ║"
    echo "║            Instalação Unificada v2.0                      ║"
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
    echo -e "\n0) ❌ Sair"
    echo -e "\n${YELLOW}Digite os números separados por espaço (ex: 1 2 3):${NC}"
}

# Função para verificar se comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Função para backup de arquivos
backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cp "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
        msg_color "Backup criado: ${file}.backup" "$YELLOW"
    fi
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
    if [[ ! -d "$REPO_DIR" ]]; then
        msg_color "ERRO: Diretório do projeto não encontrado em $REPO_DIR" "$RED"
        exit 1
    fi

    msg_color "✓ Pré-requisitos atendidos!" "$GREEN"
}

# Função para instalação segura de pacotes
safe_pacman_install() {
    local packages=("$@")
    msg_color "Instalando pacotes pacman: ${packages[*]}" "$CYAN"

    if ! sudo pacman -S "${packages[@]}" --needed --noconfirm; then
        msg_color "ERRO: Falha na instalação de pacotes: ${packages[*]}" "$RED"
        return 1
    fi
    msg_color "✓ Pacotes instalados com sucesso!" "$GREEN"
}

# Carregar brew no ambiente atual
load_brew() {
    if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        BREW_INSTALLED=true
        msg_color "✓ Homebrew carregado no ambiente atual" "$GREEN"
    else
        msg_color "AVISO: Homebrew não encontrado" "$YELLOW"
        return 1
    fi
}

# ============================================================================
# INSTALAÇÃO BASE
# ============================================================================
install_base() {
    msg_color "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$BLUE"
    msg_color "🔧 INICIANDO CONFIGURAÇÃO BASE" "$BLUE"
    msg_color "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" "$BLUE"

    # Instalar pacotes essenciais
    safe_pacman_install wget git tmux curl nano eog fastfetch stow flatpak \
        nwg-look zsh gnome-disk-utility cpupower cava cronie nodejs npm kitty || return 1

    # Instalar Oh My ZSH
    msg_color "Instalando Oh My ZSH..." "$CYAN"

    # Fazer backup e remover configurações antigas
    backup_file "$HOME/.zshrc"
    backup_file "$HOME/.zsh_aliases"

    # Remover diretórios antigos
    for dir in "$HOME/.oh-my-zsh/" "$HOME/.poshthemes/" "$HOME/.tmux/" \
               "$HOME/.themes/Dracula/" "$HOME/.local/share/icons/dracula/" \
               "$HOME/.local/share/icons/dracula-light/" "$HOME/.local/share/icons/dracula-dark/"; do
        [[ -d "$dir" ]] && rm -rf "$dir"
    done

    # Remover arquivos de configuração antigos
    [[ -f "$HOME/.zshrc" ]] && rm -f "$HOME/.zshrc"
    [[ -f "$HOME/.zsh_aliases" ]] && rm -f "$HOME/.zsh_aliases"

    # Instalar Oh My ZSH
    if [[ -f "$TERMINALS_DIR/oh_my_zsh_install.sh" ]]; then
        cd "$TERMINALS_DIR" && ./oh_my_zsh_install.sh
        if [[ $? -ne 0 ]]; then
            msg_color "ERRO: Falha na instalação do Oh My ZSH" "$RED"
            return 1
        fi
    else
        msg_color "ERRO: Script oh_my_zsh_install.sh não encontrado" "$RED"
        return 1
    fi

    # Instalar Oh My Posh
    msg_color "Instalando Oh My Posh..." "$CYAN"

    if ! sudo wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh; then
        msg_color "ERRO: Falha no download do Oh My Posh" "$RED"
        return 1
    fi

    sudo chmod +x /usr/local/bin/oh-my-posh

    # Baixar e instalar temas do Oh My Posh
    mkdir -p "$HOME/.poshthemes"
    if ! wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O "$HOME/.poshthemes/themes.zip"; then
        msg_color "ERRO: Falha no download dos temas do Oh My Posh" "$RED"
        return 1
    fi

    unzip -q "$HOME/.poshthemes/themes.zip" -d "$HOME/.poshthemes"
    rm "$HOME/.poshthemes/themes.zip"

    # Link para tema customizado
    if [[ -f "$CUSTOMIZATION_DIR/zsh/tj-dracula.omp.json" ]]; then
        ln -sf "$CUSTOMIZATION_DIR/zsh/tj-dracula.omp.json" "$HOME/.poshthemes/tj-dracula.omp.json"
    else
        msg_color "AVISO: Tema customizado tj-dracula.omp.json não encontrado" "$YELLOW"
    fi

    # Criar diretórios
    msg_color "Criando diretórios necessários..." "$CYAN"
    mkdir -p "$HOME/Development" "$HOME/.icons" "$HOME/.themes" "$HOME/scripts"

    # Instalar fontes
    msg_color "Instalando fontes..." "$CYAN"
    FONT_DIR="/usr/share/fonts/"
    LOCAL_FONT_DIR="$HOME/.local/share/fonts/"
    mkdir -p "$LOCAL_FONT_DIR"
    sudo mkdir -p "$FONT_DIR"

    cd "$REPO_DIR/fonts" || return 1
    sudo cp FantasqueSansMNerdFont-Regular.ttf "$FONT_DIR" 2>/dev/null || true
    sudo cp FantasqueSansMNerdFont-Regular.ttf "$LOCAL_FONT_DIR" 2>/dev/null || true
    sudo cp FantasqueSansMNerdFontMono-Regular.ttf "$FONT_DIR" 2>/dev/null || true
    sudo cp FantasqueSansMNerdFontMono-Regular.ttf "$LOCAL_FONT_DIR" 2>/dev/null || true

    fc-cache -fv >/dev/null 2>&1

    # Instalar logo-ls
    msg_color "Instalando logo-ls..." "$CYAN"
    cp "$CUSTOMIZATION_DIR/bash/logo-ls_Linux_x86_64.tar.gz" "$HOME/Downloads"
    cd "$HOME/Downloads" || return 1
    tar -zxf logo-ls_Linux_x86_64.tar.gz
    sudo cp logo-ls_Linux_x86_64/logo-ls /usr/local/bin
    rm -r logo-ls_Linux_x86_64 logo-ls_Linux_x86_64.tar.gz

    # Ativar Flatpak
    msg_color "Ativando acesso aos apps Flatpak..." "$CYAN"
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    # Instalar HomeBrew
    msg_color "Instalando HomeBrew..." "$CYAN"
    cd "$REPO_DIR/packages" || return 1

    if ! ./brew_install.sh; then
        msg_color "ERRO: Falha na instalação do Homebrew" "$RED"
        return 1
    fi

    # Carregar Homebrew no ambiente atual
    load_brew

    # Configurar HomeBrew no shell
    msg_color "Configurando HomeBrew nos shells..." "$CYAN"
    if ! grep -q "linuxbrew" "$HOME/.bashrc" 2>/dev/null; then
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
    fi

    if ! grep -q "linuxbrew" "$HOME/.zshrc" 2>/dev/null; then
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
    fi

    # Configurar Tmux
    msg_color "Configurando Tmux..." "$CYAN"
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        git clone --quiet https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
    ln -sf "$CUSTOMIZATION_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

    # Iniciar e configurar tmux silenciosamente
    tmux new-session -d -s "install_temp" 2>/dev/null || true
    tmux source "$HOME/.tmux.conf" 2>/dev/null || true
    tmux kill-session -t "install_temp" 2>/dev/null || true

    # Aplicar configurações com Stow
    msg_color "Aplicando configurações com Stow..." "$CYAN"
    cd "$HOME/Development/Arch_Linux/stow" || return 1

    declare -a configs=(
        "cava"
        "lazygit"
	"nvim"
	"hypr"
        "gtk-3.0"
        "gtk-4.0"
        "kitty"
    )

    for config in "${configs[@]}"; do
        target_dir="$HOME/.config/$config"
        [[ -e "$target_dir" ]] && rm -rf "$target_dir"
        mkdir -p "$target_dir"
        stow -v -t "$target_dir" "$config" 2>/dev/null || true
    done

    # Criar symlinks para Xresources e xprofile
    [[ -e "$HOME/Xresources" ]] && rm "$HOME/Xresources"
    ln -s "$HOME/Development/Arch_Linux/stow/Xresources" "$HOME/Xresources" 2>/dev/null || true

    [[ -e "$HOME/.xprofile" ]] && rm "$HOME/.xprofile"
    ln -s "$HOME/Development/Arch_Linux/stow/.xprofile" "$HOME/.xprofile" 2>/dev/null || true

    [[ -e "$HOME/Xauthority" ]] && rm "$HOME/Xauthority"
    ln -s "$HOME/Development/Arch_Linux/stow/Xauthority" "$HOME/Xauthority" 2>/dev/null || true

    # Stow scripts
    cd "$HOME/Development/Arch_Linux/" || return 1
    mkdir -p "$HOME/scripts"
    stow -v -t "$HOME/scripts" scripts 2>/dev/null || true

    # Instalar tema Dracula
    msg_color "Instalando tema Dracula..." "$CYAN"
    install_theme_dracula

    # Criar symlinks para arquivos de configuração
    msg_color "Criando symlinks para configurações..." "$CYAN"

    declare -A file_links=(
        ["$HOME/.zshrc"]="$HOME/Development/Arch_Linux/customization/zsh/.zshrc"
        ["$HOME/.zsh_aliases"]="$HOME/Development/Arch_Linux/customization/zsh/.zsh_aliases"
        ["$HOME/.gitconfig"]="$HOME/Development/Arch_Linux/customization/git/.gitconfig"
    )

    for target in "${!file_links[@]}"; do
        source="${file_links[$target]}"
        [[ -e "$target" ]] && rm "$target"
        ln -s "$source" "$target"
    done

    msg_color "\n✓ Configuração base concluída com sucesso!" "$GREEN"
}

# ============================================================================
# INSTALAÇÃO DE APLICAÇÕES
# ============================================================================
install_apps() {
    msg_color "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$BLUE"
    msg_color "🚀 INICIANDO INSTALAÇÃO DE APLICAÇÕES" "$BLUE"
    msg_color "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" "$BLUE"

    # Verificar se homebrew está disponível
    if ! command_exists brew; then
        msg_color "Homebrew não encontrado. Tentando carregar..." "$YELLOW"
        load_brew

        if ! command_exists brew; then
            msg_color "ERRO: Homebrew não está disponível. Execute a instalação base primeiro!" "$RED"
            return 1
        fi
    fi

    # Instalar pacotes via Homebrew
    msg_color "Instalando pacotes via Homebrew..." "$CYAN"
    brew install git-delta onefetch || msg_color "AVISO: Falha em alguns pacotes Homebrew" "$YELLOW"

    # Instalar aplicações via Flatpak
    msg_color "Instalando aplicações via Flatpak..." "$CYAN"
    declare -a flatpak_apps=(
        "com.getpostman.Postman"
        "org.telegram.desktop"
        "com.snes9x.Snes9x"
        "org.duckstation.DuckStation"
        "net.pcsx2.PCSX2"
        "com.heroicgameslauncher.hgl"
    )

    for app in "${flatpak_apps[@]}"; do
        msg_color "Instalando $app..." "$CYAN"
        if ! flatpak install flathub "$app" -y; then
            msg_color "AVISO: Falha na instalação de $app" "$YELLOW"
        fi
    done

    # Verificar/instalar yay
    if ! command_exists yay; then
        msg_color "yay não encontrado. Instalando..." "$CYAN"
        sudo pacman -S --needed git base-devel --noconfirm
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/yay
    fi

    # Instalar pacotes AUR
    msg_color "Instalando pacotes AUR..." "$CYAN"
    declare -a aur_packages=(
        "visual-studio-code-bin"
        "yazi"
        "steam"
	"google-chrome"
        "github-desktop"
    )

    for package in "${aur_packages[@]}"; do
        msg_color "Instalando $package..." "$CYAN"
        if ! yay -S "$package" --noconfirm; then
            msg_color "AVISO: Falha na instalação de $package" "$YELLOW"
        fi
    done

    # Configurar shell padrão para ZSH
    msg_color "Configurando ZSH como shell padrão..." "$CYAN"
    sudo chsh -s /usr/bin/zsh "$USER" || msg_color "AVISO: Falha ao mudar shell padrão" "$YELLOW"

    # Copiar configurações para root
    msg_color "Copiando configurações para usuário root..." "$CYAN"
    cd "$HOME/Development/Arch_Linux/customization/bash" || return 1
    sudo cp .bashrc_root /root/.bashrc 2>/dev/null || true
    sudo cp .bash_aliases_root /root/.bash_aliases 2>/dev/null || true

    cd "$HOME/Development/Arch_Linux/customization/zsh" || return 1
    sudo cp .zshrc_root /root/.zshrc 2>/dev/null || true
    sudo cp .zsh_aliases_root /root/.zsh_aliases 2>/dev/null || true
    sudo cp -r "$HOME/.oh-my-zsh" /root 2>/dev/null || true

    cd "$HOME/Development/Arch_Linux/" || return 1
    sudo cp -r scripts /root 2>/dev/null || true

    # Instalar tema Dracula para TTY
    msg_color "Instalando tema Dracula para TTY..." "$CYAN"
    cd "$HOME/Downloads/" || return 1
    wget -q https://github.com/dracula/tty/archive/master.zip -O dracula-tty.zip
    unzip -q dracula-tty.zip

    echo "" >> "$HOME/.zshrc"
    echo "# Dracula TTY Theme" >> "$HOME/.zshrc"
    cat tty-master/dracula-tty.sh >> "$HOME/.zshrc"

    if [[ -f "$HOME/.local/share/omarchy/default/bashrc" ]]; then
        cat tty-master/dracula-tty.sh >> "$HOME/.local/share/omarchy/default/bashrc"
    fi

    rm -rf "$HOME/Downloads/tty-master/" "$HOME/Downloads/dracula-tty.zip"

    # Configurar Yazi com tema Dracula
    msg_color "Configurando Yazi com tema Dracula..." "$CYAN"
    if command_exists yazi; then
        git clone --quiet https://github.com/dracula/yazi.git ~/.config/yazi/flavors/dracula.yazi 2>/dev/null || true

        if [[ -f "$HOME/.config/yazi/theme.toml" ]]; then
            rm "$HOME/.config/yazi/theme.toml"
        fi

        echo "[flavor]" > "$HOME/.config/yazi/theme.toml"
        echo 'use = "dracula"' >> "$HOME/.config/yazi/theme.toml"
    fi

    msg_color "\n✓ Instalação de aplicações concluída com sucesso!" "$GREEN"
}

# ============================================================================
# INSTALAÇÃO AVANÇADA
# ============================================================================
install_advanced() {
    msg_color "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$BLUE"
    msg_color "🤖 INICIANDO INSTALAÇÃO DE FERRAMENTAS AVANÇADAS" "$BLUE"
    msg_color "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" "$BLUE"

    # Instalar Ollama
    msg_color "Instalando Ollama..." "$CYAN"
    if ! command_exists ollama; then
        curl -fsSL https://ollama.com/install.sh | sh
        sleep 2
    else
        msg_color "Ollama já está instalado" "$YELLOW"
    fi

    # Executar modelo llama3
    msg_color "Iniciando modelo llama3 no Ollama..." "$CYAN"
    ollama run llama3 &
    sleep 5

    # Configurar cpupower para performance
    msg_color "Configurando CPU para modo performance..." "$CYAN"
    if command_exists cpupower; then
        sudo cpupower frequency-set -g performance || msg_color "AVISO: Falha ao configurar cpupower" "$YELLOW"
    fi

    # Verificar se Docker está instalado
    if ! command_exists docker; then
        msg_color "Docker não encontrado. Instalando..." "$CYAN"
        sudo pacman -S docker docker-compose --needed --noconfirm
        sudo systemctl enable --now docker
        sudo usermod -aG docker "$USER"
        msg_color "IMPORTANTE: Você precisa fazer logout e login novamente para usar o Docker sem sudo" "$YELLOW"
    fi

    # Deploy do Portainer (se o diretório existir)
    PORTAINER_DIR="/run/media/tarcisio/Seagate/Programas/Dockerfiles"
    if [[ -d "$PORTAINER_DIR" ]]; then
        msg_color "Fazendo deploy do Portainer..." "$CYAN"
        cd "$PORTAINER_DIR" || return 1

        if [[ -f "portainer-agent-stack.yml" ]]; then
            docker stack deploy -c portainer-agent-stack.yml portainer || \
                msg_color "AVISO: Falha no deploy do Portainer" "$YELLOW"
        else
            msg_color "AVISO: Arquivo portainer-agent-stack.yml não encontrado" "$YELLOW"
        fi
    else
        msg_color "AVISO: Diretório $PORTAINER_DIR não encontrado. Pulando Portainer..." "$YELLOW"
    fi

    # Executar Open WebUI
    msg_color "Iniciando Open WebUI..." "$CYAN"
    docker run -d --network=host \
        -v open-webui:/app/backend/data \
        -e OLLAMA_BASE_URL=http://127.0.0.1:11434 \
        --name open-webui \
        --restart always \
        ghcr.io/open-webui/open-webui:main || \
        msg_color "AVISO: Falha ao iniciar Open WebUI (pode já estar rodando)" "$YELLOW"

    msg_color "\n✓ Instalação de ferramentas avançadas concluída!" "$GREEN"
}

# ============================================================================
# INSTALAR APENAS TEMA DRACULA
# ============================================================================
install_theme_dracula() {
    msg_color "Instalando tema Dracula..." "$CYAN"

    cd "$HOME/Downloads/" || return 1

    # Instalar tema GTK Dracula
    if [[ ! -d "$HOME/.themes/Dracula" ]]; then
        wget -q https://github.com/dracula/gtk/archive/master.zip -O dracula-gtk.zip
        unzip -q dracula-gtk.zip
        mv gtk-master Dracula
        mv Dracula "$HOME/.themes"
        rm -f dracula-gtk.zip
    else
        msg_color "Tema GTK Dracula já instalado" "$YELLOW"
    fi

    # Instalar ícones Dracula
    if [[ ! -d "$HOME/.local/share/icons/Tela-dracula" ]]; then
        git clone --quiet https://github.com/vinceliuice/Tela-icon-theme.git
        cd Tela-icon-theme || return 1
        ./install.sh -n dracula
        cd .. && rm -rf Tela-icon-theme
    else
        msg_color "Ícones Dracula já instalados" "$YELLOW"
    fi

    msg_color "✓ Tema Dracula instalado!" "$GREEN"
}

# ============================================================================
# INSTALAÇÃO COMPLETA
# ============================================================================
install_complete() {
    msg_color "\n╔═══════════════════════════════════════════════════════════╗" "$GREEN"
    msg_color "║         INICIANDO INSTALAÇÃO COMPLETA                       ║" "$GREEN"
    msg_color "╚═══════════════════════════════════════════════════════════╝\n" "$GREEN"

    install_base
    if [[ $? -eq 0 ]]; then
        install_apps
    else
        msg_color "ERRO: Instalação base falhou. Abortando..." "$RED"
        return 1
    fi

    if [[ $? -eq 0 ]]; then
        install_advanced
    else
        msg_color "AVISO: Instalação de apps falhou. Continuando com avançado..." "$YELLOW"
        install_advanced
    fi

    msg_color "\n╔═══════════════════════════════════════════════════════════╗" "$GREEN"
    msg_color "║    🎉 INSTALAÇÃO COMPLETA FINALIZADA COM SUCESSO! 🎉   ║" "$GREEN"
    msg_color "╚═══════════════════════════════════════════════════════════╝\n" "$GREEN"

    msg_color "IMPORTANTE: Para aplicar todas as mudanças:" "$YELLOW"
    msg_color "  1. Faça logout e login novamente" "$YELLOW"
    msg_color "  2. Ou execute: source ~/.zshrc" "$YELLOW"
}

# ============================================================================
# MENU PRINCIPAL
# ============================================================================
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
                4) install_theme_dracula ;;
                5) install_complete ;;
                *) msg_color "Opção inválida: $choice" "$RED" ;;
            esac
        done

        echo -e "\n${GREEN}Pressione Enter para continuar...${NC}"
        read -r
    done
}

# ============================================================================
# INÍCIO DO SCRIPT
# ============================================================================
main() {
    show_header
    check_prerequisites
    main_menu
}

# Executar apenas se for chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

sudo reboot now
