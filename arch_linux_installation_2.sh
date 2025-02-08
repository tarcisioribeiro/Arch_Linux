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

title_blue "Instalação - Parte 2"

brew install eza glow tldr fd git-delta zoxide
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
mv ~/.config/nvim ~/.config/nvim_old
sudo rm -r ~/.config/nvim_old
mkdir -p ~/.config/nvim && stow -v -t ~/.config/nvim ~/repos/Arch_Linux/stow/nvim
sudo pacman -S ruby

cd ~
cp ~/repos/Arch_Linux/wallpapers/*.png ~/Pictures/
cp -r ~/repos/Arch_Linux/wallpapers/wallpapers ~/Pictures/
mkdir -p ~/scripts && stow -v -t ~/scripts ~/repos/Arch_Linux/scripts/

cd ~/Downloads/
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
mv gtk-master Dracula
mv Dracula ~/.themes
rm master.zip
cd ~/Downloads
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh -n dracula
cd ..
sudo rm -r Tela-icon-theme

cd ~/Downloads

title_blue "Instalando o Yay..."

cd ~/Downloads
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
sudo rm -r yay
yay -Syu

touch ~/.poshthemes/tj-dracula.omp.json && stow -v -t  ~/.poshthemes/tj-dracula.omp.json ~/repos/Arch_Linux/customization/zsh/tj-dracula.omp.json
touch ~/.gitconfig && stow -v -t ~/.gitconfig ~/repos/Arch_Linux/customization/git/.gitconfig
touch ~/.tmux.conf && stow -v -t ~/.tmux.conf ~/repos/Arch_Linux/customization/tmux/.tmux.conf
touch ~/.config/starship.toml && stow -v -t ~/.config/starship.toml ~/repos/Terminal/customization/starship/starship.toml
touch ~/.bashrc && stow -v -t ~/.bashrc ~/repos/Arch_Linux/shell_files/.bashrc
touch ~/.zshrc && stow -v -t ~/.zshrc ~/repos/Arch_Linux/shell_files/.bashrc
touch ~/.bash_aliases && stow -v -t ~/.bash_aliases ~/repos/Arch_Linux/shell_files/.bash_aliases
touch ~/.zsh_aliases && stow -v -t ~/.zsh_aliases ~/repos/Arch_Linux/shell_files/.zsh_aliases

title "Reiniciando a máquina..."

sudo reboot now
