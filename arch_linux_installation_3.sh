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

title_green "Instalação - Parte 3"

systemctl --user enable pipewire.service
systemctl --user enable hypridle.service

title_blue "Começando a instalação do VirtualBox..."

sleep 5

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

sleep 5

title_blue "Gerando chave SSH..."

ssh-keygen

title_blue "Instalando o snap..."

sleep 5

cd ~/Downloads
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si

sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service
sudo ln -s /var/lib/snapd/snap /snap

cd ~/Downloads
sudo rm -r snapd

title_green "Instalação do snap concluída. Recomendamos que reinicie a máquina antes de instalar os programas."

sleep 5

title_blue "Instalando o Speed Test."

sleep 5

cp ~/repos/Arch_Linux/packages/ookla-speedtest-1.2.0-linux-x86_64.tgz ~/Downloads
cd ~/Downloads
sudo tar -xvzf ookla-speedtest-1.2.0-linux-x86_64.tgz -C /usr/bin
rm ookla-speedtest-1.2.0-linux-x86_64.tgz

sudo snap install youtube-music-desktop-app spotify dbeaver-ce
sudo snap install youtube-music-desktop-app
sudo snap install spotify
sudo snap install dbeaver-ce
sudo snap install android-studio --classic

sleep 5

yay -S --noconfirm deluge deluge-gtk
yay -S github-desktop-bin --noconfirm

sleep 5

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

yay -S --noconfirm ly
sudo systemctl enable ly.service
sudo cp ~/repos/Arch_Linux/shell_files/config.ini /etc/ly/

powerprofilesctl set performance

title_green "Instalação finalizada."
sleep 5

title_red "Reiniciando a máquina."
sleep 5

sudo reboot now
