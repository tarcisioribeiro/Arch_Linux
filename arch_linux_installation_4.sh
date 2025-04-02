#!/usr/bin/bash
title_red() {
  clear
  echo ""
  echo -e "\033[31m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
  echo ""
  sleep 3
}

title_green() {
  clear
  echo ""
  echo -e "\033[32m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
  echo ""
  sleep 3
}

title_blue() {
  clear
  echo ""
  echo -e "\033[34m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
  echo ""
  sleep 3
}

red() {
  echo -e "\033[31m$1\033[0m"
}

green() {
  echo -e "\033[32m$1\033[0m"
}

blue() {
  echo -e "\033[34m$1\033[0m"
}

clearwait() {
  clear
  sleep 5
}

title_blue "Instalação - Parte 4"

clearwait
blue "Instalando pacotes yay..."
yay -S ly
yay -S tdf
yay -S upscayl-bin
yay -S cava
yay -S yazi
yay -S google-chrome
yay -S visual-studio-code-bin
yay -S make
yay -S gnome-calculator-gtk3
yay -S ngrok
yay -S wlogout
yay -S deluge
yay -S deluge-gtk
yay -S wlogout
yay -S github-desktop-bin
yay -S telegram-desktop
yay -S evolution
yay -S discord
yay -S i3-gaps
yay -S i3lock-color
yay -S asdf-vm

clearwait
blue "Instalando pacotes snap..."
sudo snap install android-studio --classic
sudo snap install dbeaver-ce
sudo snap install youtube-music-desktop-app
sudo snap install notion-desktop
sudo systemctl enable ly.service
sudo ln ~/repos/Arch_Linux/shell_files/config.ini /etc/ly/config.ini

remove_directories() {
  directories=(
    "$HOME/Documentos"
    "$HOME/Imagens"
    "$HOME/Modelos"
    "$HOME/Músicas"
    "$HOME/Downloads"
    "$HOME/Público"
    "$HOME/Vídeos"
  )

  for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
      echo "Diretório $dir encontrado. Removendo..."
      sudo rm -r "$dir"
    else
      echo "Diretório $dir não encontrado."
    fi
  done
}
remove_directories

clearwait
green "Configurando links para o usuário root"
sudo ln ~/repos/Arch_Linux/shell_files/bashrc_sudo /root/.bashrc
sudo ln ~/repos/Arch_Linux/shell_files/zshrc_sudo /root/.zshrc
sudo ln ~/repos/Arch_Linux/shell_files/bash_aliases_sudo /root/.bash_aliases
sudo ln ~/repos/Arch_Linux/shell_files/zsh_aliases_sudo /root/.zsh_aliases
sudo cp -r ~/.oh-my-bash /root
sudo cp -r ~/.oh-my-zsh /root
sudo mkdir /root/.config
sudo mkdir -p /root/.config/nvim && cd ~/repos/Arch_Linux/stow && stow -v -t /root/.config/nvim nvim

clearwait
blue "Configurando o i3wm"
cd ~/repos/Arch_Linux/stow/
mkdir -p ~/.config/i3 && stow -v -t ~/.config/i3 i3
mkdir -p ~/.config/polybar && stow -v -t ~/.config/polybar polybar
mkdir -p ~/.config/rofi && stow -v -t ~/.config/rofi rofi
mkdir -p ~/.config/nitrogen && stow -v -t ~/.config/nitrogen nitrogen

cd ~
mkdir ~/Downloads/

(
  crontab -l 2>/dev/null
  echo "0 22 * * * shutdown"
) | crontab -

title_green "Instalação concluída."

sudo reboot now
