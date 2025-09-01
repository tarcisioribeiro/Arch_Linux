#!/bin/bash
set -e

# Cores para mensagens
msg_color() {
  echo -e "\n\033[$1m$2\033[0m\n"
  sleep 1
}

# Verificar se homebrew está instalado
if ! command -v brew >/dev/null 2>&1; then
  msg_color "31" "ERRO: Homebrew não está instalado!"
  exit 1
fi

# Instalar pacotes via Homebrew
msg_color "34" "Instalando pacotes via Homebrew..."
brew install git-delta onefetch

# Instalar aplicações via Flatpak
msg_color "34" "Instalando aplicações via Flatpak..."
flatpak_apps=(
  "com.getpostman.Postman"
  "org.telegram.desktop" 
  "com.snes9x.Snes9x"
  "org.duckstation.DuckStation"
  "net.pcsx2.PCSX2"
  "com.heroicgameslauncher.hgl"
)

for app in "${flatpak_apps[@]}"; do
  if ! flatpak install flathub "$app" -y; then
    msg_color "33" "AVISO: Falha na instalação de $app"
  fi
done

# Verificar se yay está instalado
if ! command -v yay >/dev/null 2>&1; then
  msg_color "33" "AVISO: yay não está instalado. Instalando..."
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/yay
fi

# Instalar pacotes AUR
msg_color "34" "Instalando pacotes AUR..."
aur_packages=(
  "visual-studio-code-bin"
  "yazi"
  "steam"
  "github-desktop"
)

for package in "${aur_packages[@]}"; do
  if ! yay -S "$package" --noconfirm; then
    msg_color "33" "AVISO: Falha na instalação de $package"
  fi
done

echo "Instalação concluída!"

sudo chsh -s /usr/bin/zsh
cd "$HOME/Development/Arch_Linux/customization/bash" || exit
sudo cp .bashrc_root /root && sudo mv /root/.bashrc_root /root/.bashrc
sudo cp .bash_aliases_root /root && sudo mv /root/.bash_aliases_root /root/.bash_aliases

cd "$HOME/Development/Arch_Linux/customization/zsh" || exit
sudo cp .zshrc_root /root && sudo mv /root/.zshrc_root /root/.zshrc
sudo cp .zsh_aliases_root /root && sudo mv /root/.zsh_aliases_root /root/.zsh_aliases
sudo cp -r "$HOME/.oh-my-zsh" /root

cd "$HOME/Development/Arch_Linux/"
sudo cp -r scripts /root

cd "$HOME/Downloads/"
wget https://github.com/dracula/tty/archive/master.zip
unzip master.zip
echo "" >>"$HOME/.zshrc"
echo "" >"$HOME/.local/share/omarchy/default/bashrc"
cat tty-master/dracula-tty.sh >>"$HOME/.zshrc"
cat tty-master/dracula-tty.sh >>"$HOME/.local/share/omarchy/default/bashrc"
rm -rf "$HOME/Downloads/tty-master/"
rm "$HOME/Downloads/master.zip"

git clone https://github.com/dracula/yazi.git ~/.config/yazi/flavors/dracula.yazi
rm "$HOME/.config/yazi/theme.toml"
echo "[flavor]" >>"$HOME/.config/yazi/theme.toml"
echo 'use = "dracula"' >>"$HOME/.config/yazi/theme.toml"
