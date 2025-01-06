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

blue "\nComeçando a instalação do VirtualBox...\n"

sleep 3

sudo pacman -Syu virtualbox virtualbox-host-dkms linux-headers linux-headers-lts virtualbox-guest-iso
sudo gpasswd -a $USER vboxusers
sudo gpasswd -a $USERS vboxusers
sudo modprobe vboxdrv
yay -S virtualbox-ext-oracle
sudo systemctl enable vboxweb.service
sudo systemctl start vboxweb.service

green "\nInstalação do Virtualbox concluída.\n"

sleep 3

blue "\nGerando chave SSH...\n"

ssh-keygen

blue "\nInstalando o snap...\n"

sleep 3

cd ~/Downloads
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si

sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service
sudo ln -s /var/lib/snapd/snap /snap

green "\nInstalação do snap concluída. Recomendamos que reinicie a máquina antes de instalar os programas.\n"