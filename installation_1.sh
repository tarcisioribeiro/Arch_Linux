#!/usr/bin/bash
set -e

# Função para exibir mensagens coloridas
msg_color() {
  clear
  echo -e "\n\033[$1m$2\033[0m\n"
  sleep 2
}

# Função para verificar se um comando existe
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Função para verificar se é Arch Linux
check_arch_linux() {
  if [[ ! -f /etc/arch-release ]]; then
    msg_color "31" "ERRO: Este script é apenas para Arch Linux!"
    exit 1
  fi
}

# Função para verificar conexão com internet
check_internet() {
  if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    msg_color "31" "ERRO: Sem conexão com a internet!"
    exit 1
  fi
}

# Função para backup de arquivos importantes
backup_file() {
  local file="$1"
  if [[ -f "$file" ]]; then
    cp "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
    msg_color "33" "Backup criado: ${file}.backup.$(date +%Y%m%d_%H%M%S)"
  fi
}

# Função para instalação segura de pacotes
safe_pacman_install() {
  local packages=("$@")
  msg_color "34" "Instalando pacotes: ${packages[*]}"
  
  if ! sudo pacman -S "${packages[@]}" --needed --noconfirm; then
    msg_color "31" "ERRO: Falha na instalação de pacotes: ${packages[*]}"
    return 1
  fi
}

# Verificações iniciais
msg_color "34" "Verificando pré-requisitos..."
check_arch_linux
check_internet

# Instalação de pacotes essenciais
safe_pacman_install wget git tmux curl nano eog fastfetch stow flatpak \
  nwg-look zsh gnome-disk-utility cpupower cava cronie nodejs npm kitty

# Definição de diretórios
REPO_DIR="$HOME/Development/Arch_Linux/"
TERMINALS_DIR="$REPO_DIR/packages/"
CUSTOMIZATION_DIR="$REPO_DIR/customization"

# Verificar se o diretório do projeto existe
if [[ ! -d "$REPO_DIR" ]]; then
  msg_color "31" "ERRO: Diretório do projeto não encontrado em $REPO_DIR"
  exit 1
fi

msg_color "34" "Instalando o Oh My ZSH..."

# Fazer backup e remover configurações antigas
backup_file "$HOME/.zshrc"
backup_file "$HOME/.zsh_aliases"

# Remover diretórios antigos (com confirmação se não estiver vazio)
for dir in "$HOME/.oh-my-zsh/" "$HOME/.poshthemes/" "$HOME/.tmux/" \
           "$HOME/.themes/Dracula/" "$HOME/.local/share/icons/dracula/" \
           "$HOME/.local/share/icons/dracula-light/" "$HOME/.local/share/icons/dracula-dark/"; do
  if [[ -d "$dir" ]]; then
    rm -rf "$dir"
  fi
done

# Remover arquivos de configuração antigos
for file in "$HOME/.zshrc" "$HOME/.zsh_aliases"; do
  if [[ -f "$file" ]]; then
    rm -f "$file"
  fi
done

# Instalar Oh My ZSH
if [[ -f "$TERMINALS_DIR/oh_my_zsh_install.sh" ]]; then
  cd "$TERMINALS_DIR" && ./oh_my_zsh_install.sh
  if [[ $? -ne 0 ]]; then
    msg_color "31" "ERRO: Falha na instalação do Oh My ZSH"
    exit 1
  fi
else
  msg_color "31" "ERRO: Script oh_my_zsh_install.sh não encontrado"
  exit 1
fi

msg_color "34" "Instalando o Oh My Posh..."

# Baixar e instalar Oh My Posh
if ! sudo wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh; then
  msg_color "31" "ERRO: Falha no download do Oh My Posh"
  exit 1
fi

sudo chmod +x /usr/local/bin/oh-my-posh

# Baixar e instalar temas
mkdir -p "$HOME/.poshthemes"
if ! wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O "$HOME/.poshthemes/themes.zip"; then
  msg_color "31" "ERRO: Falha no download dos temas do Oh My Posh"
  exit 1
fi

unzip -q "$HOME/.poshthemes/themes.zip" -d "$HOME/.poshthemes"
rm "$HOME/.poshthemes/themes.zip"

# Link para tema customizado
if [[ -f "$CUSTOMIZATION_DIR/zsh/tj-dracula.omp.json" ]]; then
  ln -sf "$CUSTOMIZATION_DIR/zsh/tj-dracula.omp.json" "$HOME/.poshthemes/tj-dracula.omp.json"
else
  msg_color "33" "AVISO: Tema customizado tj-dracula.omp.json não encontrado"
fi

msg_color "34" "Criando diretórios..."
mkdir -p "$HOME/Development" "$HOME/.icons" "$HOME/.themes" "$HOME/scripts"

msg_color "34" "Instalando fontes..."
FONT_DIR="/usr/share/fonts/"
LOCAL_FONT_DIR="$HOME/.local/share/fonts/"
mkdir -p $LOCAL_FONT_DIR
sudo mkdir -p $FONT_DIR
cd "$REPO_DIR/fonts" || exit
sudo cp JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf "$FONT_DIR"
sudo cp JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf "$LOCAL_FONT_DIR"
sudo cp JetBrainsMonoNerdFontMono-*.ttf "$FONT_DIR"
sudo cp JetBrainsMonoNerdFontMono-*.ttf "$LOCAL_FONT_DIR"
sudo cp FantasqueSansMNerdFont-Regular.ttf "$FONT_DIR"
sudo cp FantasqueSansMNerdFont-Regular.ttf "$LOCAL_FONT_DIR"
sudo cp FantasqueSansMNerdFontMono-Regular.ttf "$FONT_DIR"
sudo cp FantasqueSansMNerdFontMono-Regular.ttf "$LOCAL_FONT_DIR"

msg_color "34" "Instalando logo-ls..."
cp "$CUSTOMIZATION_DIR/bash/logo-ls_Linux_x86_64.tar.gz" "$HOME/Downloads"
cd "$HOME/Downloads" || exit
tar -zxf logo-ls_Linux_x86_64.tar.gz
sudo cp logo-ls_Linux_x86_64/logo-ls /usr/local/bin
rm -r logo-ls_Linux_x86_64 logo-ls_Linux_x86_64.tar.gz

msg_color "34" "Ativando o acesso aos apps Flatpak..."
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

msg_color "34" "Instalando o HomeBrew..."
cd "$REPO_DIR/packages" && ./brew_install.sh || exit

msg_color "34" "Configurando Tmux..."
git clone --quiet https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
ln -sf "$CUSTOMIZATION_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
tmux new-session -d -s "dev"
tmux source "$HOME/.tmux.conf"
tmux kill-session -t "dev"

msg_color "34" "Configurando HomeBrew no shell..."
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' | tee -a "$HOME/.bashrc" "$HOME/.zshrc" >/dev/null

cd "$HOME/Development/Arch_Linux/stow" || exit

declare -a configs=(
  "cava"
  "lazygit"
  "gtk-3.0"
  "gtk-4.0"
  "kitty"
)

for config in "${configs[@]}"; do
  target_dir="$HOME/.config/$config"
  if [ -e "$target_dir" ]; then
    rm -rf "$target_dir"
  fi
  mkdir -p "$target_dir"
  stow -v -t "$target_dir" "$config"
done

if [ -e "$HOME/Xresources" ]; then
  rm "$HOME/Xresources"
fi
ln -s "$HOME/Development/Arch_Linux/stow/Xresources" "$HOME/Xresources"

if [ -e "$HOME/.xprofile" ]; then
  rm "$HOME/.xprofile"
fi
ln -s "$HOME/Development/Arch_Linux/stow/.xprofile" "$HOME/.xprofile"

if [ -e "$HOME/Xauthority" ]; then
  rm "$HOME/Xauthority"
fi
ln -s "$HOME/Development/Arch_Linux/stow/Xauthority" "$HOME/Xauthority"

cd "$HOME/Development/Arch_Linux/" || exit
mkdir -p "$HOME/scripts" && stow -v -t "$HOME/scripts" scripts

cd "$HOME/Downloads/" || exit
wget -q https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
mv gtk-master Dracula
mv Dracula "$HOME/.themes"
rm master.zip
cd "$HOME/Downloads" || exit
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme || exit
./install.sh -n dracula
cd ..
sudo rm -r Tela-icon-theme

files=(
  "$HOME/.zshrc:$HOME/Development/Arch_Linux/customization/zsh/.zshrc"
  "$HOME/.zsh_aliases:$HOME/Development/Arch_Linux/customization/zsh/.zsh_aliases"
  "$HOME/.gitconfig:$HOME/Development/Arch_Linux/customization/git/.gitconfig"
)

for file in "${files[@]}"; do
  target="${file%%:*}"
  source="${file##*:}"
  if [ -e "$target" ]; then
    rm "$target"
  fi
  ln -s "$source" "$target"
done
