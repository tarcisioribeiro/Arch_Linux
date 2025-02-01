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

sleep 3

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

clear
echo ""
title_green "Instalação do Virtualbox concluída."
echo ""

sleep 3

clear
echo ""
title_blue "Gerando chave SSH..."
echo ""

ssh-keygen

clear
echo ""
title_blue "Instalando o snap..."
echo ""

sleep 3

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

sleep 3

clear
echo ""
title_blue "Instalando o Speed Test."

sleep 3

cp ~/repos/Arch_Linux/packages/ookla-speedtest-1.2.0-linux-x86_64.tgz ~/Downloads
cd ~/Downloads
sudo tar -xvzf ookla-speedtest-1.2.0-linux-x86_64.tgz -C /usr/bin
rm ookla-speedtest-1.2.0-linux-x86_64.tgz

sleep 3

yay -S deluge deluge-gtk tdf upscayl-bin wlogout
yay -S github-desktop-bin

sleep 3

clear
echo ""
title_blue "Baixando o Flutter..."
echo ""
sleep 3

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

clear
echo ""
title_red "Reiniciando a máquina."
echo ""
sleep 3

sudo reboot now
