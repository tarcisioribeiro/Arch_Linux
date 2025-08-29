#!/bin/bash
brew install git-delta onefetch

flatpak install flathub com.getpostman.Postman
flatpak install flathub org.telegram.desktop
flatpak install flathub com.snes9x.Snes9x
flatpak install flathub org.duckstation.DuckStation
flatpak install flathub net.pcsx2.PCSX2
flatpak install flathub com.heroicgameslauncher.hgl

yay -S visual-studio-code-bin
yay -S yazi
yay -S steam
yay -S github-desktop

echo "Instalação concluída!"

sudo chsh -s /usr/bin/zsh
cd "$HOME/Development/Arch_Linux/customization/bash" || exit
sudo cp .bashrc_root /root && sudo mv /root/.bashrc_root /root/.bashrc
sudo cp .bash_aliases_root /root && sudo mv /root/.bash_aliases_root /root/.bash_aliases

cd "$HOME/Development/Arch_Linux/customization/zsh" || exit
sudo cp .zshrc_root /root && sudo mv /root/.zshrc_root /root/.zshrc
sudo cp .zsh_aliases_root /root && sudo mv /root/.zsh_aliases_root /root/.zsh_aliases
sudo cp -r "$HOME/.oh-my-zsh" /root

cd "$HOME/Development/Arch_Linux/"
sudo cp -r scripts /root

cd "$HOME/Downloads/"
wget https://github.com/dracula/tty/archive/master.zip
unzip master.zip
echo "" >>"$HOME/.zshrc"
echo "" >"$HOME/.local/share/omarchy/default/bashrc"
cat tty-master/dracula-tty.sh >>"$HOME/.zshrc"
cat tty-master/dracula-tty.sh >>"$HOME/.local/share/omarchy/default/bashrc"
rm -rf "$HOME/Downloads/tty-master/"
rm "$HOME/Downloads/master.zip"

git clone https://github.com/dracula/yazi.git ~/.config/yazi/flavors/dracula.yazi
rm "$HOME/.config/yazi/theme.toml"
echo "[flavor]" >>"$HOME/.config/yazi/theme.toml"
echo 'use = "dracula"' >>"$HOME/.config/yazi/theme.toml"
