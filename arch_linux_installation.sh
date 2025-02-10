#!/usr/bin/bash
sudo pacman -S toilet zsh --noconfirm

title_red() {
  clear && echo "" && echo -e "\033[31m$(toilet --font pagga --filter border --width 200 "$1")\033[0m" && echo "" && sleep 5
}

title_green() {
  clear && echo "" && echo -e "\033[32m$(toilet --font pagga --filter border --width 200 "$1")\033[0m" && echo "" && sleep 5
}

title_blue() {
  clear && echo "" && echo -e "\033[34m$(toilet --font pagga --filter border --width 200 "$1")\033[0m" && echo "" && sleep 5
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
  tar gzip wofi firefox stow feh \
  flatpak python3 python-pip vlc \
  obs-studio zsh tmux waybar btop \
  bat nm-connection-editor openssh ufw \
  gnome-tweaks gnome-disk-utility power-profiles-daemon \
  cliphist wl-clipboard dunst network-manager-applet \
  man-db grim slurp nwg-look nitrogen \
  hyprlock hypridle stow polybar \
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
sudo rm /etc/bluetooth/main.conf
cd ~/repos/Arch_Linux/shell_files/
sudo ln main.conf /etc/bluetooth/main.conf
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

clearwait
blue "Copiando arquivos de configuração"
sudo mkdir -p /boot/grub/themes/dracula/ && cd ~/repos/Arch_Linux/stow/grub
sudo stow -v -t /boot/grub/themes/dracula/ dracula
cd ~/repos/Arch_Linux/shell_files/
sudo ln grub /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

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
cd ~/repos/Arch_Linux/shell_files/
ln mimeapps.list ~/.config/mimeapps.list
ln picom.conf ~/.config/picom.conf

clearwait
title_green "Alterando o shell do sistema..."
blue "Certifique-se de digitar corretamente a sua senha."
read -p "Pressione ENTER para confirmar e prosseguir."

chsh -s /usr/bin/zsh
clearwait
title_blue "Instalação - Oh My Zsh"
~/repos/Arch_Linux/packages/oh_my_zsh_install.sh

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
cp ~/repos/Arch_Linux/customization/bash/logo-ls_Linux_x86_64.tar.gz ~/Downloads
cd ~/Downloads
tar -zxf logo-ls_Linux_x86_64.tar.gz
cd ~/Downloads/logo-ls_Linux_x86_64
sudo cp logo-ls /usr/local/bin
cd ~/Downloads
sudo rm -r logo-ls_Linux_x86_64
rm logo-ls_Linux_x86_64.tar.gz

clearwait
title_blue "Instalando o HomeBrew..."
~/repos/Arch_Linux/packages/brew_install.sh

clearwait
title_blue "Instalando o Oh My Bash..."
bash ~/repos/Arch_Linux/packages/oh_my_bash_install.sh

clearwait
title_blue "Instalando o Starship..."
~/repos/Arch_Linux/packages/starship_install.sh

clearwait
blue "Tmux Plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln ~/repos/Arch_Linux/customization/tmux/.tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

clearwait
blue "Fontes"
sudo cp ~/repos/Arch_Linux/fonts/JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/DS-DIGIB.TTF /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-Italic.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-Bold.ttf /usr/share/fonts
sudo cp ~/repos/Arch_Linux/fonts/JetBrainsMonoNerdFontMono-BoldItalic.ttf /usr/share/fonts

sudo systemctl enable --now ufw.service
sudo ufw enable
sudo systemctl start sshd
sudo systemctl enable sshd
sudo ufw allow SSH

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc

source ~/.bashrc

title_blue "Instalação - Parte 2"
clearwait
blue "Pacotes Brew"
brew install eza glow tldr fd git-delta zoxide

clearwait
blue "Lazyvim"
mkdir -p ~/.config/nvim && cd ~/repos/Arch_Linux/stow/ && stow -v -t ~/.config/nvim nvim
sudo pacman -S ruby --noconfirm
mkdir -p ~/scripts && cd ~/repos/Arch_Linux/ && stow -v -t ~/scripts scripts
sudo chsh -s /usr/bin/zsh
sudo mkdir -p /root/scripts && cd /home/tarcisio/repos/Arch_Linux/ && sudo stow -v -t /root/scripts scripts

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

for archive in "${archive[@]}"; do
  archive_expansion=$(eval echo $archive)

  if [ -f "$archive_expansion" ]; then
    rm -f "$archive_expansion"
    echo "Arquivo '$archive_expansion' removido com sucesso."
  else
    echo "Arquivo '$archive_expansion' não encontrado."
  fi
done

clearwait
blue "Links simbólicos de arquivos"
ln ~/repos/Arch_Linux/customization/zsh/tj-dracula.omp.json ~/.poshthemes/tj-dracula.omp.json
ln ~/repos/Arch_Linux/customization/git/.gitconfig ~/.gitconfig
ln ~/repos/Arch_Linux/customization/starship/starship.toml ~/.config/starship.toml
ln ~/repos/Arch_Linux/shell_files/.bashrc ~/.bashrc
ln ~/repos/Arch_Linux/shell_files/.zshrc ~/.zshrc
ln ~/repos/Arch_Linux/shell_files/.bash_aliases ~/.bash_aliases
ln ~/repos/Arch_Linux/shell_files/.zsh_aliases ~/.zsh_aliases
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
cp ~/repos/Arch_Linux/packages/ookla-speedtest-1.2.0-linux-x86_64.tgz ~/Downloads
cd ~/Downloads
sudo tar -xvzf ookla-speedtest-1.2.0-linux-x86_64.tgz -C /usr/bin
rm ookla-speedtest-1.2.0-linux-x86_64.tgz

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
cp ~/repos/Arch_Linux/packages/youtube-music-desktop-app.zip .
unzip youtube-music-desktop-app.zip
mv youtube-music-desktop-app ~/snap
rm youtube-music-desktop-app.zip
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
yay -S --noconfirm yazi
yay -S --noconfirm google-chrome
yay -S --noconfirm visual-studio-code-bin
yay -S --noconfirm make
yay -S --noconfirm ngrok
yay -S --noconfirm wlogout
yay -S --noconfirm deluge
yay -S --noconfirm deluge-gtk
yay -S wlogout
yay -S --noconfirm github-desktop-bin
yay -S --noconfirm telegram-desktop
yay -S --noconfirm evolution
yay -S --noconfirm discord
yay -S --noconfirm i3-gaps
yay -S --noconfirm i3lock-color
yay -S --noconfirm asdf-vm

clearwait
blue "Instalando pacotes snap..."
sudo snap install android-studio --classic
sudo snap install dbeaver-ce
sudo snap install youtube-music-desktop-app
sudo snap install notion-desktop
sudo systemctl enable ly.service
sudo ln ~/repos/Arch_Linux/shell_files/config.ini /etc/ly/config.ini

remove_directories() {
  directories=(
    "$HOME/Documentos"
    "$HOME/Imagens"
    "$HOME/Modelos"
    "$HOME/Músicas"
    "$HOME/Downloads"
    "$HOME/Público"
    "$HOME/Vídeos"
  )

  for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
      echo "Diretório $dir encontrado. Removendo..."
      sudo rm -r "$dir"
    else
      echo "Diretório $dir não encontrado."
    fi
  done
}
remove_directories

clearwait
green "Configurando links para o usuário root"
sudo ln ~/repos/Arch_Linux/shell_files/bashrc_sudo /root/.bashrc
sudo ln ~/repos/Arch_Linux/shell_files/zshrc_sudo /root/.zshrc
sudo ln ~/repos/Arch_Linux/shell_files/bash_aliases_sudo /root/.bash_aliases
sudo ln ~/repos/Arch_Linux/shell_files/zsh_aliases_sudo /root/.zsh_aliases
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

# ASDF Java
sudo pacman -S --noconfirm jq jre21-opnejdk jdk21-openjdk openjdk21-doc openjdk21-doc
asdf plugin add java https://github.com/halcyon/asdf-java.git

systemctl --user enable --now hypridle.service

title_green "Instalação concluída."

sudo reboot now