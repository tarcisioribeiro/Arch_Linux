#!/usr/bin/bash

red() {
    echo -e "\033[31m$1\033[0m"
}
green() {
    echo -e "\033[32m$1\033[0m"
}

blue() {
    echo -e "\033[34m$1\033[0m"
}

brew install eza glow tldr fd git-delta
nvm install 20.17.0
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
mv ~/.config/nvim ~/.config/nvim_old
cp -r ~/repos/Terminal/customization/nvim ~/.config
sudo rm -r ~/.config/nvim_old
sudo pacman -S ruby

cd ~
cp ~/repos/Arch_Linux/wallpapers/*.png ~/Pictures/
cp ~/repos/Arch_Linux/scripts/*.sh ~/scripts/
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

wget https://github.com/dracula/zsh-syntax-highlighting/archive/master.zip
unzip master.zip
cp zsh-syntax-highlighting-master/zsh-syntax-highlighting.sh ~/scripts/
rm master.zip
sudo rm -r zsh-syntax-highlighting-master
cd ~/Downloads

gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
gsettings set org.gnome.desktop.interface icon-theme "dracula-dark"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono NFM"
cd ~

rmdir "Documentos"
rmdir "Imagens"
rmdir "Músicas"
rmdir "Público"
rmdir "Modelos"
rmdir "Vídeos"

yay -S cava yazi google-chrome visual-studio-code-bin make gnome-calculator-gtk3 ngrok hyprsunset