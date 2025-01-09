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

sudo snap install youtube-music-desktop-app

yay -S deluge deluge-gtk

sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd

cd ~/Downloads

touch 20-enp3s0.network

echo "[Network]" >> 20-enp3s0.network
echo "DHCP=no" >> 20-enp3s0.network
echo "Address=192.168.2.200/24" >> 20-enp3s0.network
echo "Gateway=192.168.2.1" >> 20-enp3s0.network
echo "DNS=8.8.8.8 8.8.4.4" >> 20-enp3s0.network

sudo mv 20-enp3s0.network /etc/systemd/network/

touch 20-wlan0.network

echo "[Network]" >> 20-wlan0.network
echo "DHCP=no" >> 20-wlan0.network
echo "Address=192.168.2.201/24" >> 20-wlan0.network
echo "Gateway=192.168.2.1" >> 20-wlan0.network
echo "DNS=8.8.8.8 8.8.4.4" >> 20-wlan0.network
echo "" >> 20-wlan0.network
echo "[Wireless]" >> 20-wlan0.network
echo "SSID=Tarcisio_5G" >> 20-wlan0.network
echo "Security=wpa-psk" >> 20-wlan0.network
echo "Key=orrARDrdr27!" >> 20-wlan0.network

sudo mv 20-wlan0.network /etc/systemd/network/

sudo systemctl restart systemd-networkd

yay -S ly
sudo systemctl enable ly.service
sudo cp ~/repos/Arch_Linux/shell_files/config.ini /etc/ly/

blue "\nMontando os discos...\n"
sleep 5

sudo blkid /dev/sda1
red "\nAnote o UUID abaixo, você tem 30 segundos.\n"
sleep 30
sudo mkdir -p /mnt/sda1
blue "\nAgora, edite o arquivo adicionando o seguinte:\n\nUUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX  /mnt/sda1  ext4  defaults  0  2"
sleep 30
sudo nano /etc/fstab
sudo mount -a

green "\nInstalação finalizada.\n"
sleep 5

red "\nReiniciando a máquina.\n"
sleep 5

sudo reboot now