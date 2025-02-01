#!/usr/bin/bash
title_red() {
    echo -e "\033[31m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
}

title_green() {
    echo -e "\033[32m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
}

title_blue() {
    echo -e "\033[34m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
}

title_blue "Instalação - Parte 4"
echo ""

yay -S --noconfirm ly
sudo systemctl enable ly.service
sudo cp ~/repos/Arch_Linux/shell_files/config.ini /etc/ly/

sudo snap install android-studio --classic
sudo snap install dbeaver-ce
sudo snap install youtube-music-desktop-app

title_green "Instalação concluída."
echo ""

sleep 3

sudo reboot now
