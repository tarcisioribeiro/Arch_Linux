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

systemctl --user enable pipewire.service
systemctl --user enable hypridle.service

blue "\nComeçando a instalação do VirtualBox...\n"

sleep 3

sudo pacman -Syu virtualbox virtualbox-host-dkms linux-headers linux-lts-headers virtualbox-guest-iso
sudo dkms install vboxhost/$(pacman -Qi virtualbox-host-dkms | grep Version | awk '{print $3}')
sudo gpasswd -a $USER vboxusers
sudo gpasswd -a $USERS vboxusers
sudo modprobe vboxdrv
sudo modprobe vboxnetflt
sudo modprobe vboxnetadp
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

cd ~/Downloads
sudo rm -r snapd

green "\nInstalação do snap concluída. Recomendamos que reinicie a máquina antes de instalar os programas.\n"

sleep 3

blue "\nInstalando o Speed Test.\n"

sleep 3

cp ~/repos/Arch_Linux/packages/ookla-speedtest-1.2.0-linux-x86_64.tgz ~/Downloads
cd ~/Downloads
sudo tar -xvzf ookla-speedtest-1.2.0-linux-x86_64.tgz -C /usr/bin
rm ookla-speedtest-1.2.0-linux-x86_64.tgz

yay -S ly
sudo systemctl enable ly.service

green "\nInstalação finalizada.\n"
sleep 5

red "\nReiniciando a máquina.\n"
sleep 5

sudo reboot now