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
clear
echo ""

green "Instalando pacotes YAY..."

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
yay -S hyprsunset
yay -S wlogout
yay -S deluge
yay -S deluge-gtk
yay -S wlogout
yay -S github-desktop-bin
sudo systemctl enable ly.service
sudo cp ~/repos/Arch_Linux/shell_files/config.ini /etc/ly/

clear
echo ""
title_green "Instalando pacotes snap..."
echo ""

sudo snap install android-studio --classic
sudo snap install dbeaver-ce
sudo snap install youtube-music-desktop-app



clear
echo ""
title_green "Instalação concluída."
echo ""

sleep 3

sudo reboot now
