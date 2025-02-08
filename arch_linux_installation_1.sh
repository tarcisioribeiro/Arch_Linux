#!/usr/bin/bash
sudo pacman -S toilet zsh --noconfirm
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

cd ~
mkdir -p Pictures
mkdir -p scripts
mkdir -p Downloads
mkdir -p Desktop
mkdir -p ~/.icons
mkdir -p ~/.themes
sudo pacman -Syu

title "Instalação - Parte 1"

title_green "Atualizando o sistema..."

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
scrcpy picom rofi shotcut


sudo pacman -Syu
sudo pacman -S bluez blueman bluez-utils

title_blue "Ativação do Bluetooth"

echo "Procure pela seção AutoEnable, e descomente a linha #AutoEnable=True. Após isso, salve e feche o arquivo."

echo ""

read -p "Pressione ENTER para confirmar e prosseguir."

sudo nano /etc/bluetooth/main.conf

sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

clear

sudo usermod -aG wheel,storage,disk $USER
sudo gpasswd -a $USER input

sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd

cd ~/repos/Arch_Linux/stow

mkdir -p ~/.config
mkdir -p ~/.config/hypr && stow -v -t ~/.config/hypr hypr
mkdir -p ~/.config/kitty && stow -v -t ~/.config/kitty kitty
mkdir -p ~/.config/waybar && stow -v -t ~/.config/waybar waybar
mkdir -p ~/.config/wofi && stow -v -t ~/.config/wofi wofi
mkdir -p ~/.config/btop && stow -v -t ~/.config/btop btop
mkdir -p ~/.config/cava && stow -v -t ~/.config/cava cava
mkdir -p ~/.config/gtk-3.0 && stow -v -t ~/.config/gtk-3.0 gtk
mkdir -p ~/.config/dunst && stow -v -t ~/.config/dunst dunst
mkdir -p ~/.config/wlogout && stow -v -t ~/.config/wlogout wlogout
mkdir -p ~/.config/nvim && stow -v -t ~/.config/nvim nvim
touch ~/.config/mimeapps.list && stow -v -t ~/.config/mimeapps.list mimeapps.list
touch ~/.config/picom.conf && stow -v -t ~/.config/picom.conf picom.conf

title_green "Alterando o shell do sistema..."

echo "Certifique-se de digitar corretamente a sua senha."
echo ""
read -p "Pressione ENTER para confirmar e prosseguir."


chsh -s /usr/bin/zsh

title_green "Instalação - Oh My ZSH"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cd ~
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

cp ~/repos/Arch_Linux/customization/bash/logo-ls_Linux_x86_64.tar.gz ~/Downloads
cd ~/Downloads
tar -zxf logo-ls_Linux_x86_64.tar.gz
cd ~/Downloads/logo-ls_Linux_x86_64
sudo cp logo-ls /usr/local/bin

cd ~/Downloads
sudo rm -r logo-ls_Linux_x86_64
rm logo-ls_Linux_x86_64.tar.gz

# Brew
title_blue "Instalando o HomeBrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Oh My Bash
title_blue "Instalando o Oh My Bash..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Starship
title_blue "Instalando o Starship..."
curl -sS https://starship.rs/install.sh | sh

# Tmux Plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Fontes
sudo cp ~/repos/Arch_Linux/fonts/JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/DS-DIGIB.TTF /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-Italic.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-Bold.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-BoldItalic.ttf /usr/share/fonts

cd ~/Downloads
wget https://github.com/dracula/zsh-syntax-highlighting/archive/master.zip
unzip master.zip
cp zsh-syntax-highlighting-master/zsh-syntax-highlighting.sh ~/scripts/
rm master.zip
sudo rm -r zsh-syntax-highlighting-master

sudo systemctl enable --now ufw.service
sudo ufw enable

sudo systemctl start sshd
sudo systemctl enable sshd

sudo ufw allow SSH

title_blue "Reiniciando a máquina."

sudo reboot now
