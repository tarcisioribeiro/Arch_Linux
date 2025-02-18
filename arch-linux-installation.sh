#!/usr/bin/bash
sudo pacman -S toilet zsh --noconfirm

title_red() {
  clear
  echo ""
  echo -e "\033[31m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
  echo ""
  sleep 5
}

title_green() {
  clear
  echo ""
  echo -e "\033[32m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
  echo ""
  sleep 5
}

title_blue() {
  clear
  echo ""
  echo -e "\033[34m$(toilet --font pagga --filter border --width 200 "$1")\033[0m"
  echo ""
  sleep 5
}

red() {
  echo "" && echo -e "\033[31m$1\033[0m" && echo ""
}

green() {
  echo "" && echo -e "\033[32m$1\033[0m" && echo ""
}

blue() {
  echo "" && echo -e "\033[34m$1\033[0m" && echo ""
}

clearwait() {
  clear && sleep 5
}

sudo mkdir -p /mnt/sda1
sudo mount /dev/sda1 /mnt/sda1/
echo "/dev/sda1 /mnt/sda1 ext4 defaults,x-gvfs-show 0 2" | sudo tee -a /etc/fstab

mkdir -p ~/Pictures
mkdir -p ~/scripts
mkdir -p ~/Downloads
mkdir -p ~/Desktop
mkdir -p ~/.icons
mkdir -p ~/.themes
sudo pacman -Syu

title_blue "Instalação - Parte 1"
clearwait
title_green "Atualizando o sistema..."
sudo pacman -S curl wget iwd neofetch \
  hyprpaper nano neovim net-tools git curl wget \
  ttf-dejavu cmake ninja clang pkgconf \
  noto-fonts noto-fonts-emoji ttf-liberation \
  gst-libav gst-plugins-good gst-plugins-bad \
  gst-plugins-ugly ffmpeg gstreamer hyprland \
  kitty xdg-desktop-portal xdg-desktop-portal-hyprland \
  zip unzip p7zip unrar fontconfig \
  tar gzip wofi firefox stow feh cronie \
  flatpak python3 python-pip vlc mpv \
  obs-studio zsh tmux waybar btop locate \
  bat nm-connection-editor openssh ufw \
  gnome-tweaks gnome-disk-utility power-profiles-daemon \
  cliphist wl-clipboard dunst network-manager-applet \
  man-db grim slurp nwg-look nitrogen jdk-openjdk \
  hyprlock hypridle stow polybar jq jre-openjdk \
  glib2 gnome-settings-daemon base-devel polkit-gnome \
  gsettings-desktop-schemas nautilus gedit \
  pavucontrol wpa_supplicant obsidian \
  gimp eog cargo scdoc libreoffice-still \
  rhythmbox iniparser pyright fzf \
  fastfetch font-manager nodejs npm \
  scrcpy picom rofi shotcut xorg-xrandr \
  gnome gnome-extra gnome-shell i3 \
  xorg xorg-xdm dmenu i3status ttf-dejavu --noconfirm

clearwait
green "Pacotes instalados."

# Blueooth
sudo pacman -Syu
sudo pacman -S bluez blueman bluez-utils --noconfirm
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
sudo usermod -aG wheel,storage,disk $USER
sudo gpasswd -a $USER input
sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd

clearwait
blue "Links simbólicos de diretórios com o Stow"
cd ~/repos/Arch_Linux/stow
mkdir -p ~/.config/hypr && stow -v -t ~/.config/hypr hypr
mkdir -p ~/.config/kitty && stow -v -t ~/.config/kitty kitty
mkdir -p ~/.config/waybar && stow -v -t ~/.config/waybar waybar
mkdir -p ~/.config/wofi && stow -v -t ~/.config/wofi wofi
mkdir -p ~/.config/btop && stow -v -t ~/.config/btop btop
mkdir -p ~/.config/cava && stow -v -t ~/.config/cava cava
mkdir -p ~/.config/gtk-3.0 && stow -v -t ~/.config/gtk-3.0 gtk
mkdir -p ~/.config/dunst && stow -v -t ~/.config/dunst dunst
mkdir -p ~/.config/wlogout && stow -v -t ~/.config/wlogout wlogout
mkdir -p ~/.vim && stow -v -t ~/.vim vim
cd ~/repos/Arch_Linux/shell-files/
ln mimeapps.list ~/.config/mimeapps.list
ln picom.conf ~/.config/picom.conf

clearwait
title_green "Alterando o shell do sistema..."
blue "Certifique-se de digitar corretamente a sua senha."
read -p "Pressione ENTER para confirmar e prosseguir."

chsh -s /usr/bin/zsh
clearwait
title_blue "Instalação - Oh My Zsh"
cd ~/repos/Arch_Linux/
sh packages/oh-my-zsh-install.sh

clearwait
title_blue "Instalação do Oh My Posh"
cd ~
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

clearwait
title_blue "Instalação do logo-ls"
cp ~/repos/Arch_Linux/packages/logo-ls.tar.gz ~/Downloads
cd ~/Downloads
tar -zxf logo-ls.tar.gz
cd ~/Downloads/logo-ls_Linux_x86_64/
sudo cp logo-ls /usr/local/bin
cd ~/Downloads
sudo rm -r logo-ls_Linux_x86_64
rm logo-ls.tar.gz

cd ~/repos/Arch_Linux

clearwait
title_blue "Instalando o HomeBrew..."
bash packages/brew-install.sh

clearwait
title_blue "Instalando o Oh My Bash..."
bash packages/oh-my-bash-install.sh

clearwait
title_blue "Instalando o Starship..."
sh packages/starship-install.sh

clearwait
blue "Tmux Plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln ~/repos/Arch_Linux/stow/tmux/.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

clearwait
blue "Fontes"
cd ~/repos/Arch_Linux/fonts
sudo cp JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf /usr/share/fonts
sudo cp DS-DIGIB.TTF /usr/share/fonts
sudo cp JetBrainsMonoNerdFontMono-Italic.ttf /usr/share/fonts
sudo cp JetBrainsMonoNerdFontMono-Bold.ttf /usr/share/fonts
sudo cp JetBrainsMonoNerdFontMono-BoldItalic.ttf /usr/share/fonts

sudo systemctl enable --now ufw.service
sudo ufw enable
sudo systemctl start sshd
sudo systemctl enable sshd
sudo ufw allow SSH

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc

sleep 5
source ~/.bashrc
sleep 5

title_blue "Instalação - Parte 2"
clearwait
blue "Pacotes Brew"
brew install eza glow tldr fd git-delta yazi
brew install eza glow tldr fd git-delta yazi
brew install jesseduffield/lazygit/lazygit

clearwait
blue "Lazyvim"
mkdir -p ~/.config/nvim && cd ~/repos/Arch_Linux/stow/ && stow -v -t ~/.config/nvim nvim
mkdir -p ~/scripts && cd ~/repos/Arch_Linux/ && stow -v -t ~/scripts scripts
sudo chsh -s /usr/bin/zsh
sudo mkdir -p /root/scripts
cd ~/repos/Arch_Linux
sudo stow -v -t /root/scripts scripts

clearwait
blue "Tema Dracula GTK"
cd ~/Downloads/
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
mv gtk-master Dracula
mv Dracula ~/.themes
rm master.zip

clearwait
blue "Tema Dracula Icons"
cd ~/Downloads
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh -n dracula
cd ..
sudo rm -r Tela-icon-theme

clearwait
title_blue "Instalando o Yay..."
cd ~/Downloads
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~/Downloads
sudo rm -r yay
yay -Syu

rm ~/.poshthemes/tj-dracula.omp.json
rm ~/.gitconfig
rm ~/.tmux.conf
rm ~/.zshrc
rm ~/.zsh_aliases
rm ~/.bashrc
rm ~/.bash_aliases
rm ~/.vimrc

clearwait
blue "Links simbólicos de arquivos"
ln ~/repos/Arch_Linux/stow/oh-my-posh/tj-dracula.omp.json ~/.poshthemes/tj-dracula.omp.json
ln ~/repos/Arch_Linux/stow/git/.gitconfig ~/.gitconfig
ln ~/repos/Arch_Linux/stow/starship/starship.toml ~/.config/starship.toml
ln ~/repos/Arch_Linux/shell-files/dracula/.bashrc ~/.bashrc
ln ~/repos/Arch_Linux/shell-files/dracula/.zshrc ~/.zshrc
ln ~/repos/Arch_Linux/shell-files/dracula/.bash_aliases ~/.bash_aliases
ln ~/repos/Arch_Linux/shell-files/dracula/.zsh_aliases ~/.zsh_aliases
ln ~/repos/Arch_Linux/shell-files/dracula/.vimrc ~/.vimrc
rm -r ~/Pictures && mkdir -p ~/Pictures && cd ~/repos/Arch_Linux && stow -v -t ~/Pictures wallpapers

sudo pacman -S --noconfirm docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

systemctl --user enable pipewire.service
systemctl --user enable hypridle.service

clearwait
blue "Instalando o VirtualBox..."
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

clearwait
title_green "Virtualbox instalado."

clearwait
title_blue "Gerando chave SSH..."
ssh-keygen

clearwait
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

clearwait
titile_green "Instalação do snap concluída."

clearwait
blue "Instalando o Speed Test."
cp ~/repos/Arch_Linux/packages/speedtest.tgz ~/Downloads
cd ~/Downloads
sudo tar -xvzf speedtest.tgz -C /usr/bin
rm speedtest.tgz

clearwait
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
cp ~/repos/Arch_Linux/packages/ytmd.zip .
unzip ytmd.zip
mv ytmd youtube-music-desktop app
mv youtube-music-desktop-app ~/snap
rm ytmd.zip
sudo rm -r Dracula
sudo rm -r snapd

powerprofilesctl set performance

title_blue "Instalação - Parte 4"

clearwait
blue "Instalando pacotes yay..."
yay -S --noconfirm ly
yay -S tdf
yay -S upscayl-bin
yay -S --noconfirm cava
yay -S --noconfirm google-chrome
yay -S --noconfirm visual-studio-code-bin
yay -S --noconfirm make
yay -S --noconfirm ngrok
yay -S --noconfirm wlogout
yay -S --noconfirm deluge
yay -S --noconfirm deluge-gtk
yay -S wlogout
yay -S --noconfirm telegram-desktop
yay -S --noconfirm evolution
yay -S --noconfirm discord
yay -S --noconfirm i3-gaps
yay -S --noconfirm i3lock-color
yay -S --noconfirm asdf-vm

clearwait
blue "Instalando pacotes snap..."
sudo snap install android-studio --classic
sudo snap install android-studio --classic
sudo snap install dbeaver-ce
sudo snap install youtube-music-desktop-app
sudo snap install notion-desktop
sudo systemctl enable ly.service

rm -r ~/Documentos/ && rm -r ~/Imagens/ && rm -r ~/Modelos/ && rm -r ~/Músicas/
rm -r ~/Público/ && rm -r ~/Vídeos/

clearwait
green "Configurando links para o usuário root"
sudo ln ~/repos/Arch_Linux/shell-files/root/.bashrc /root/.bashrc
sudo ln ~/repos/Arch_Linux/shell-files/root/.zshrc /root/.zshrc
sudo ln ~/repos/Arch_Linux/shell-files/root/.bash_aliases /root/.bash_aliases
sudo ln ~/repos/Arch_Linux/shell-files/root/.zsh_aliases /root/.zsh_aliases
sudo cp -r ~/.oh-my-bash /root
sudo cp -r ~/.oh-my-zsh /root
sudo mkdir /root/.config
sudo mkdir -p /root/.config/nvim && cd ~/repos/Arch_Linux/stow && stow -v -t /root/.config/nvim nvim

clearwait
blue "Configurando o i3wm"
cd ~/repos/Arch_Linux/stow/
mkdir -p ~/.config/i3 && stow -v -t ~/.config/i3 i3
mkdir -p ~/.config/polybar && stow -v -t ~/.config/polybar polybar
mkdir -p ~/.config/rofi && stow -v -t ~/.config/rofi rofi
mkdir -p ~/.config/nitrogen && stow -v -t ~/.config/nitrogen nitrogen

cd ~
mkdir ~/Downloads/

sudo rm -r ~/go

# ASDF Packages
asdf plugin add java https://github.com/halcyon/asdf-java.git
asdf plugin add php https://github.com/asdf-community/asdf-php.git

systemctl --user enable --now hypridle.service

gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.interface icon-theme "dracula-dark"
gsettings set org.gnome.shell.extensions.user-theme name "Dracula"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono NFM 11"

sudo systemctl enable --now cronie.service

sudo pacman -S postgresql --noconfirm
sudo -iu postgres initdb -D /var/lib/postgres/data
sudo systemctl enable postgresql
sudo systemctl start postgresql

title_blue "PostgreSQL"
clearwait
blue "Altere sua senha, executando o seguinte comando:"
blue "ALTER USER postgres PASSWORD 'sua_senha_aqui';"
sleep 5
echo ""
read -p "Pressione ENTER para prosseguir."
echo ""
sudo -iu postgres psql

sudo updatedb
sudo ln -s /usr/lib/libmpv.so /usr/lib/libmpv.so.1

clearwait
blue "Instalando o DeepSeek..."
curl -fsSL https://ollama.com/install.sh | sh
sudo systemctl start ollama
sudo systemctl enable ollama
ollama run deepseek-r1

title_green "Instalação concluída."

sudo reboot now
