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

title_green "Instalação - Parte 3"

systemctl --user enable pipewire.service
systemctl --user enable hypridle.service

title_blue "Instalando o Yay..."

cd ~/Downloads
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
sudo rm -r yay
yay -Syu

title_blue "Instalando o VirtualBox..."

sudo pacman -Syu --noconfirm virtualbox virtualbox-host-dkms linux-headers linux-lts-headers virtualbox-guest-iso
sudo dkms install vboxhost/$(pacman -Qi virtualbox-host-dkms | grep Version | awk '{print $3}')
sudo gpasswd -a $USER vboxusers
sudo gpasswd -a $USERS vboxusers
sudo modprobe vboxdrv
sudo modprobe vboxnetflt
sudo modprobe vboxnetadp
yay -S --noconfirm virtualbox-ext-oracle
sudo systemctl enable vboxweb.service
sudo systemctl start vboxweb.service

title_green "Instalação do Virtualbox concluída."

title_blue "Gerando chave SSH..."

ssh-keygen

title_blue "Instalando o snap..."

cd ~/Downloads
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si

sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service
sudo ln -s /var/lib/snapd/snap /snap

cd ~/Downloads
sudo rm -r snapd

title_green "Instalação do snap concluída."

title_blue "Instalando o Speed Test."

cp ~/repos/Arch_Linux/packages/ookla-speedtest-1.2.0-linux-x86_64.tgz ~/Downloads
cd ~/Downloads
sudo tar -xvzf ookla-speedtest-1.2.0-linux-x86_64.tgz -C /usr/bin
rm ookla-speedtest-1.2.0-linux-x86_64.tgz

title_blue "Baixando o Flutter..."

mkdir -p ~/development
cd ~/Downloads
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz
tar -xf ~/Downloads/flutter_linux_3.27.1-stable.tar.xz -C ~/development/
rm flutter_linux_3.27.1-stable.tar.xz

sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd

mkdir -p ~/snap
cd ~/Downloads
cp ~/repos/Arch_Linux/packages/youtube-music-desktop-app.zip .
unzip youtube-music-desktop-app.zip
mv youtube-music-desktop-app ~/snap
rm youtube-music-desktop-app.zip
sudo rm -r Dracula
sudo rm -r snapd

powerprofilesctl set performance

title_green "Reiniciando a máquina."

sudo reboot now
