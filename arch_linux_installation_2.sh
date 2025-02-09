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

title_blue "Instalação - Parte 2"

brew install eza glow tldr fd git-delta zoxide
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
mv ~/.config/nvim ~/.config/nvim_old
sudo rm -r ~/.config/nvim_old

 cp -r ~/repos/Arch_Linux/customization/nvim ~/.config && cd ~/repos/Arch_Linux/stow/ && stow -v -t ~/.config/nvim nvim
sudo pacman -S ruby --noconfirm

cd ~
cp ~/repos/Arch_Linux/wallpapers/*.png ~/Pictures/
cp -r ~/repos/Arch_Linux/wallpapers/wallpapers ~/Pictures/
mkdir -p ~/scripts && cd ~/repos/Arch_Linux/ && stow -v -t ~/scripts scripts/ && cp ~/scripts/*.sh ~/scripts

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
cd ~/Downloads
sudo rm -r yay
yay -Syu

cd ~/repos/Arch_Linux/customization

archives=(
    "~/.poshthemes/tj-dracula.omp.json"
    "~/.gitconfig"
    "~/.tmux.conf"
    "~/.config/starship.toml"
    "~/.bashrc"
    "~/.zshrc"
    "~/.bash_aliases"
    "~/.zsh_aliases"
)

# Itera sobre a lista de arquivos
for archive in "${archive[@]}"; do
    archive_expansion=$(eval echo $archive)
    
    # Verifica se o arquivo existe
    if [ -f "$archive_expansion" ]; then
        # Remove o arquivo
        rm -f "$archive_expansion"
        echo "Arquivo '$archive_expansion' removido com sucesso."
    else
        echo "Arquivo '$archive_expansion' não encontrado."
    fi
done

ln ~/repos/Arch_Linux/customization/zsh/tj-dracula.omp.json ~/.poshthemes/tj-dracula.omp.json
ln ~/repos/Arch_Linux/customization/git/.gitconfig ~/.gitconfig
ln ~/repos/Terminal/customization/tmux/.tmux.conf ~/.tmux.conf
ln ~/repos/Terminal/customization/starship/starship.toml ~/.config/starship.toml
ln ~/repos/Arch_Linux/customization/zsh/.bashrc ~/.bashrc
ln ~/repos/Arch_Linux/customization/zsh/.zshrc ~/.zshrc
ln ~/repos/Arch_Linux/customization/bash/bash_aliases ~/.bash_aliases
ln ~/repos/Arch_Linux/customization/zsh/.zsh_aliases ~/.zsh_aliases

title_green "Reiniciando a máquina..."

# sudo reboot now
