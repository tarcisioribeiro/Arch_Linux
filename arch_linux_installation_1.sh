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

mkdir -p ~/Pictures
mkdir -p ~/scripts
mkdir -p ~/Downloads
mkdir -p ~/Desktop
mkdir -p ~/.icons
mkdir -p ~/.themes
sudo pacman -Syu

title_blue "Instalação - Parte 1"
clearwait
title_green "Atualizando o sistema..."
sudo pacman -S curl wget iwd neofetch \
  hyprpaper nano neovim net-tools git curl wget \
  ttf-dejavu cmake ninja clang pkgconf \
  noto-fonts noto-fonts-emoji ttf-liberation \
  gst-libav gst-plugins-good gst-plugins-bad \
  gst-plugins-ugly ffmpeg gstreamer hyprland \
  kitty xdg-desktop-portal xdg-desktop-portal-hyprland \
  zip unzip p7zip unrar fontconfig \
  tar gzip wofi firefox stow feh \
  flatpak python3 python-pip vlc \
  obs-studio zsh tmux waybar btop \
  bat nm-connection-editor openssh ufw \
  gnome-tweaks gnome-disk-utility power-profiles-daemon \
  cliphist wl-clipboard dunst network-manager-applet \
  man-db grim slurp nwg-look nitrogen \
  hyprlock hypridle stow polybar \
  glib2 gnome-settings-daemon base-devel polkit-gnome \
  gsettings-desktop-schemas nautilus gedit \
  pavucontrol wpa_supplicant obsidian \
  gimp eog cargo scdoc libreoffice-still \
  rhythmbox iniparser pyright fzf \
  fastfetch font-manager nodejs npm \
  scrcpy picom rofi shotcut xorg-xrandr \
  i3 xorg xorg-xdm dmenu i3status ttf-dejavu --noconfirm

clearwait
green "Pacotes instalados."
sudo pacman -Syu
sudo pacman -S bluez blueman bluez-utils --noconfirm

clearwait
blue "Copiando arquivos de configuração"
sudo ln ~/repos/Arch_Linux/shell_files/main.conf /etc/bluetooth/main.conf
sudo mkdir -p /boot/grub/themes/ && sudo cp -r ~/repos/Arch_Linux/stow/grub/dracula/ /boot/grub/themes/
sudo ln ~/repos/Arch_Linux/shell_files/grub /etc/default/grub
sudo ln ~/repos/Arch_Linux/shell_files/sudoers /etc/sudoers

sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
sudo usermod -aG wheel,storage,disk $USER
sudo gpasswd -a $USER input
sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd

clearwait
blue "Links simbólicos de diretórios com o Stow"
cd ~/repos/Arch_Linux/stow
mkdir -p ~/.config/hypr && stow -v -t ~/.config/hypr hypr
mkdir -p ~/.config/kitty && stow -v -t ~/.config/kitty kitty
mkdir -p ~/.config/waybar && stow -v -t ~/.config/waybar waybar
mkdir -p ~/.config/wofi && stow -v -t ~/.config/wofi wofi
mkdir -p ~/.config/btop && stow -v -t ~/.config/btop btop
mkdir -p ~/.config/cava && stow -v -t ~/.config/cava cava
mkdir -p ~/.config/gtk-3.0 && stow -v -t ~/.config/gtk-3.0 gtk
mkdir -p ~/.config/dunst && stow -v -t ~/.config/dunst dunst
mkdir -p ~/.config/wlogout && stow -v -t ~/.config/wlogout wlogout
cd ~/repos/Arch_Linux/shell_files/
ln mimeapps.list ~/.config/mimeapps.list
ln picom.conf ~/.config/picom.conf

clearwait
title_green "Alterando o shell do sistema..."
blue "Certifique-se de digitar corretamente a sua senha."
read -p "Pressione ENTER para confirmar e prosseguir."

chsh -s /usr/bin/zsh
clearwait
title_blue "Instalação - Oh My Zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

clearwait
title_blue "Instalação do Oh My Posh"
cd ~
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

clearwait
title_blue "Instalação do logo-ls"
cp ~/repos/Arch_Linux/customization/bash/logo-ls_Linux_x86_64.tar.gz ~/Downloads
cd ~/Downloads
tar -zxf logo-ls_Linux_x86_64.tar.gz
cd ~/Downloads/logo-ls_Linux_x86_64
sudo cp logo-ls /usr/local/bin
cd ~/Downloads
sudo rm -r logo-ls_Linux_x86_64
rm logo-ls_Linux_x86_64.tar.gz

clearwait
blue "Brew"
title_blue "Instalando o HomeBrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

clearwait
blue "Oh My Bash"
title_blue "Instalando o Oh My Bash..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

clearwait
blue "Starship"
title_blue "Instalando o Starship..."
curl -sS https://starship.rs/install.sh | sh

clearwait
blue "Tmux Plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln ~/repos/Arch_Linux/customization/tmux/.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

clearwait
blue "Fontes"
sudo cp ~/repos/Arch_Linux/fonts/JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/DS-DIGIB.TTF /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-Italic.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-Bold.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-BoldItalic.ttf /usr/share/fonts

sudo systemctl enable --now ufw.service
sudo ufw enable
sudo systemctl start sshd
sudo systemctl enable sshd
sudo ufw allow SSH

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>.zshrc

title_blue "Reiniciando a máquina."

sudo reboot now
