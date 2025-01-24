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

title_blue "Insalação - Parte 2"

brew install eza glow tldr fd git-delta
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
mv ~/.config/nvim ~/.config/nvim_old
cp -r ~/repos/Terminal/customization/nvim ~/.config
sudo rm -r ~/.config/nvim_old
sudo pacman -S --noconfirm ruby

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

cd ~/Downloads

gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
gsettings set org.gnome.desktop.interface icon-theme "dracula-dark"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono NFM"

cd ~

if [-d "Documentos"]; then
  rmdir "Documentos"
else
  echo "Diretório não encontrado."
fi

if [-d "Imagens"]; then
  rmdir "Imagens"
else
  echo "Diretório não encontrado."
fi

if [-d "D Músicas"]; then
  rmdir "Músicas"
else
  echo "Diretório não encontrado."
fi

if [-d "Público"]; then
  rmdir "Público"
else
  echo "Diretório não encontrado."
fi

if [-d "Modelos"]; then
  rmdir "Modelos"
else
  echo "Diretório não encontrado."
fi

if [-d "Vídeos"]; then
  rmdir "Vídeos"
else
  echo "Diretório não encontrado."
fi

yay -S --noconfirm cava yazi google-chrome visual-studio-code-bin make gnome-calculator-gtk3 ngrok hyprsunset yed
