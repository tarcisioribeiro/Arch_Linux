#!/usr/bin/bash
title_red() {
    clear
    echo ""
    echo -e "\033[31m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
    echo ""
    sleep 3
}

title_green() {
    clear ""
    echo ""
    echo -e "\033[32m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
    echo ""
    sleep 3
}

title_blue() {
    clear ""
    echo ""
    echo -e "\033[34m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
    echo ""
    sleep 3
}

title_blue "Instalação - Parte 4"

title_blue "Instalando pacotes YAY..."

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
scrcpy picom rofi shotcut xrandr

sudo systemctl enable ly.service
sudo cp ~/repos/Arch_Linux/shell_files/config.ini /etc/ly/


title_green "Instalação concluída."

sudo reboot now
