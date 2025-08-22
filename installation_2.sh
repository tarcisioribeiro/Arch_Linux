#!/bin/bash

brew install fd git-delta vim lazygit eza onefetch tldr zoxide asdf

cd "$HOME/Development/Arch_Linux/packages" || exit
./asdf_packages.sh

flatpak install flathub com.getpostman.Postman

echo "Instalação concluída!"

sudo chsh -s /usr/bin/zsh
cd "$HOME/Development/Linux_Mint/customization/bash" || exit
sudo cp .bashrc_root /root && sudo mv /root/.bashrc_root /root/.bashrc
sudo cp .bash_aliases_root /root && sudo mv /root/.bash_aliases_root /root/.bash_aliases

cd "$HOME/Development/Arch_Linux/customization/zsh" || exit
sudo cp .zshrc_root /root && sudo mv /root/.zshrc_root /root/.zshrc
sudo cp .zsh_aliases_root /root && sudo mv /root/.zsh_aliases_root /root/.zsh_aliases
sudo cp -r "$HOME/.oh-my-zsh" /root

cd "$HOME/Development/Arch_Linux/"
sudo cp -r scripts /root
