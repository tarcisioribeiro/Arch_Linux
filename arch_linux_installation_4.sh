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

title_blue "Instalação - Parte 4"

title_blue "Instalando pacotes YAY..."

yay -S --noconfirm ly
yay -S --noconfirm tdf
yay -S --noconfirm upscayl-bin
yay -S --noconfirm cava
yay -S --noconfirm yazi
yay -S --noconfirm google-chrome
yay -S --noconfirm visual-studio-code-bin
yay -S --noconfirm make
yay -S --noconfirm gnome-calculator-gtk3
yay -S --noconfirm ngrok
yay -S --noconfirm hyprsunset
yay -S --noconfirm wlogout
yay -S --noconfirm deluge
yay -S --noconfirm deluge-gtk
yay -S --noconfirm wlogout
yay -S --noconfirm github-desktop-bin
yay -S --noconfirm telegram-desktop
yay -S --noconfirm evolution
yay -S --noconfirm discord
yay -S --noconfirm i3-gaps

title_blue "Instalando pacotes snap..."

sudo snap install android-studio --classic
sudo snap install dbeaver-ce
sudo snap install youtube-music-desktop-app

sudo pacman -S curl wget iwd neofetch \
hyprpaper nano neovim net-tools \
vim btop ttf-dejavu cmake ninja clang pkgconf \
noto-fonts noto-fonts-emoji ttf-liberation \
gst-libav gst-plugins-good gst-plugins-bad \
gst-plugins-ugly ffmpeg gstreamer hyprland \
kitty xdg-desktop-portal xdg-desktop-portal-hyprland \
zip unzip p7zip unrar cronie \
tar gzip wofi firefox stow feh \
flatpak python3 python-pip vlc \
obs-studio zsh tmux waybar \
bat nm-connection-editor openssh ufw \
gnome-tweaks gnome-disk-utility power-profiles-daemon \
cliphist wl-clipboard dunst network-manager-applet \
man-db grim slurp nwg-look \
hyprlock hypridle \
glib2 gnome-settings-daemon base-devel polkit-gnome \
gsettings-desktop-schemas nautilus gedit \
pavucontrol wpa_supplicant obsidian \
gimp eog cargo scdoc libreoffice-still \
rhythmbox iniparser pyright fzf \
fastfetch font-manager nodejs npm \
scrcpy picom rofi shotcut xorg-xrandr \
i3 xorg xorg-xdm dmenu i3status i3lock ttf-dejavu --noconfirm

sudo systemctl enable ly.service
sudo cp ~/repos/Arch_Linux/shell_files/config.ini /etc/ly/

sudo rm -r ~/Documentos
sudo rm -r ~/Imagens
sudo rm -r ~/Modelos
sudo rm -r ~/Músicas
sudo rm -r ~/Público
sudo rm -r ~/Vídeos

title_green "Instalação concluída."

# sudo reboot now
