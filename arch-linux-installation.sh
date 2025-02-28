#!/usr/bin/bash
sudo pacman -Syu
sudo pacman -S toilet zsh --noconfirm

title_green() {
  clear && echo "" && echo -e "\033[32m$(toilet --font pagga --filter border --width 200 "$1")\033[0m" && echo "" && sleep 2
}

title_blue() {
  clear && echo "" && echo -e "\033[34m$(toilet --font pagga --filter border --width 200 "$1")\033[0m" && echo "" && sleep 2
}

green() {
  echo "" && echo -e "\033[32m$1\033[0m" && echo ""
}

blue() {
  echo "" && echo -e "\033[34m$1\033[0m" && echo ""
}

clearwait() {
  clear && sleep 2
}

mkdir -p $HOME/Pictures && mkdir -p $HOME/scripts && mkdir -p $HOME/Downloads && mkdir -p $HOME/Desktop && mkdir -p $HOME/.icons && mkdir -p $HOME/.themes

title_blue "Instalação - Parte 1"
clearwait
title_green "Atualizando o sistema..."
sudo pacman -S curl wget iwd neofetch redshift \
  nano neovim net-tools git curl wget i3 i3lock \
  ttf-dejavu cmake ninja clang pkgconf xclip xsel \
  noto-fonts noto-fonts-emoji ttf-liberation \
  gst-libav gst-plugins-good gst-plugins-bad \
  gst-plugins-ugly ffmpeg gstreamer lxqt-powermanagement \
  kitty xdg-desktop-portal fzf stow zenity \
  zip unzip p7zip unrar fontconfig playerctl \
  tar gzip wofi firefox stow feh cronie unzip curl \
  flatpak python3 python-pip vlc mpv cmatrix \
  obs-studio zsh tmux btop locate acpi maim \
  bat nm-connection-editor openssh ufw dmenu \
  gnome-tweaks gnome-disk-utility power-profiles-daemon \
  cliphist wl-clipboard dunst network-manager-applet \
  man-db nitrogen mpc mpd gdk-pixbuf2 gtk3 adwaita-icon-theme librsvg \
  stow polybar timidity++ powertop youtube-music \
  glib2 gnome-settings-daemon base-devel polkit-gnome \
  gsettings-desktop-schemas nautilus gedit powertop \
  pavucontrol wpa_supplicant obsidian acpi scrot \
  gimp eog cargo scdoc libreoffice-still inetutils \
  rhythmbox iniparser pyright fzf postgresql mpd \
  fastfetch font-manager nodejs npm xdotool xorg-xwininfo \
  scrcpy picom rofi shotcut xorg-xrandr ranger xsettingsd \
  lxqt-config xorg xorg-xdm dmenu ttf-dejavu --noconfirm

clearwait
green "Pacotes instalados."

sudo pacman -S bluez blueman bluez-utils --noconfirm
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
sudo usermod -aG wheel,storage,disk $USER
sudo gpasswd -a $USER input

clearwait
title_blue "Instalação - Oh My Zsh"
cd $HOME/repos/Arch_Linux/
sh packages/oh-my-zsh-install.sh

clearwait
title_blue "Instalação do Oh My Posh"
cd ~
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir $HOME/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O $HOME/.poshthemes/themes.zip
unzip $HOME/.poshthemes/themes.zip -d $HOME/.poshthemes
chmod u+rw $HOME/.poshthemes/*.omp.*
rm $HOME/.poshthemes/themes.zip

clearwait
title_blue "Instalação do logo-ls"
cp $HOME/repos/Arch_Linux/packages/logo-ls.tar.gz $HOME/Downloads
cd $HOME/Downloads
tar -zxf logo-ls.tar.gz
cd $HOME/Downloads/logo-ls_Linux_x86_64/
sudo cp logo-ls /usr/local/bin
cd $HOME/Downloads
sudo rm -r logo-ls_Linux_x86_64
rm logo-ls.tar.gz

cd $HOME/repos/Arch_Linux

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
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
ln $HOME/repos/Arch_Linux/stow/tmux/.tmux.conf $HOME/.tmux.conf
tmux new-session -d -s "dev"
sleep 1
tmux source $HOME/.tmux.conf

clearwait
blue "Fontes"
cd $HOME/repos/Arch_Linux/fonts
sudo cp JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf /usr/share/fonts
sudo cp DS-DIGIB.TTF /usr/share/fonts
sudo cp JetBrainsMonoNerdFontMono-Italic.ttf /usr/share/fonts
sudo cp JetBrainsMonoNerdFontMono-Bold.ttf /usr/share/fonts
sudo cp JetBrainsMonoNerdFontMono-BoldItalic.ttf /usr/share/fonts

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zshrc

sleep 2
source $HOME/.bashrc
sleep 2

title_blue "Instalação - Parte 2"
clearwait
blue "Pacotes Brew"
brew install eza glow tldr fd git-delta yazi zoxide
brew install eza glow tldr fd git-delta yazi zoxide
brew install jesseduffield/lazygit/lazygit

clearwait
blue "Lazyvim"
mkdir -p $HOME/.config/nvim && cd $HOME/repos/Arch_Linux/stow/ && stow -v -t $HOME/.config/nvim nvim
mkdir -p $HOME/scripts && cd $HOME/repos/Arch_Linux/ && stow -v -t $HOME/scripts scripts
sudo chsh -s /usr/bin/zsh
sudo mkdir -p /root/scripts
cd $HOME/repos/Arch_Linux
sudo stow -v -t /root/scripts scripts

clearwait
blue "Tema Dracula GTK"
cd $HOME/Downloads/
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
mv gtk-master Dracula
mv Dracula $HOME/.themes
rm master.zip

clearwait
blue "Tema Dracula Icons"
cd $HOME/Downloads
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh -n dracula
cd ..
sudo rm -r Tela-icon-theme

clearwait
title_blue "Instalando o Yay..."
cd $HOME/Downloads
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd $HOME/Downloads
sudo rm -r yay
yay -Syu

sudo pacman -S --noconfirm docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

systemctl --user enable pipewire.service

clearwait
title_green "Virtualbox instalado."

clearwait
title_blue "Instalando o snap..."
cd $HOME/Downloads
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service
sudo ln -s /var/lib/snapd/snap /snap
cd $HOME/Downloads
sudo rm -r snapd
clearwait
titile_green "Instalação do snap concluída."

clearwait
blue "Instalando o Speed Test."
cp $HOME/repos/Arch_Linux/packages/speedtest.tgz $HOME/Downloads
cd $HOME/Downloads
sudo tar -xvzf speedtest.tgz -C /usr/bin
rm speedtest.tgz

clearwait
title_blue "Baixando o Flutter..."
mkdir -p $HOME/development
cd $HOME/Downloads
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz
tar -xf $HOME/Downloads/flutter_linux_3.27.1-stable.tar.xz -C $HOME/development/
rm flutter_linux_3.27.1-stable.tar.xz
sudo rm -r Dracula
sudo rm -r snapd

powerprofilesctl set performance

clearwait
blue "Instalando pacotes yay..."
yay -S --noconfirm ly cava google-chrome visual-studio-code-bin make ngrok deluge deluge-gtk evolution bibata-cursor-theme
yay -S i3-gaps i3lock-color postman-bin upscayl-bin tdf youtube-music

clearwait
blue "Instalando pacotes snap..."
sudo snap install android-studio --classic
sudo snap install android-studio --classic
sudo systemctl enable ly.service

rm -r $HOME/Documentos/ && rm -r $HOME/Imagens/ && rm -r $HOME/Modelos/ && rm -r $HOME/Músicas/ && rm -r $HOME/Público/ && rm -r $HOME/Vídeos/

clearwait
green "Configurando links para o usuário root"
sudo ln $HOME/repos/Arch_Linux/shell-files/root/.bashrc /root/.bashrc
sudo ln $HOME/repos/Arch_Linux/shell-files/root/.zshrc /root/.zshrc
sudo ln $HOME/repos/Arch_Linux/shell-files/root/.bash_aliases /root/.bash_aliases
sudo ln $HOME/repos/Arch_Linux/shell-files/root/.zsh_aliases /root/.zsh_aliases
sudo ln $HOME/repos/Arch_Linux/shell-files/root/.vimrc /root/.vimrc
sudo cp -r $HOME/.oh-my-bash /root
sudo cp -r $HOME/.oh-my-zsh /root
sudo mkdir /root/.config
sudo mkdir -p /root/.config/nvim && cd $HOME/repos/Arch_Linux/stow && stow -v -t /root/.config/nvim nvim

cd ~
mkdir $HOME/Downloads/

sudo rm -r $HOME/go

gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.interface icon-theme "dracula-dark"
gsettings set org.gnome.shell.extensions.user-theme name "Dracula"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono NFM 11"

sudo updatedb

sudo ln -s /usr/lib/libmpv.so /usr/lib/libmpv.so.1

cd $HOME/Downloads
sudo rm -r rofi
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
./setup.sh

clearwait
blue "Links simbólicos de diretórios com o Stow"
cd $HOME/repos/Arch_Linux/stow
mkdir -p $HOME/.config/btop && stow -v -t $HOME/.config/btop btop
mkdir -p $HOME/.config/cava && stow -v -t $HOME/.config/cava cava
mkdir -p $HOME/.config/dunst && stow -v -t $HOME/.config/dunst dunst
mkdir -p $HOME/.config/gtk-3.0 && stow -v -t $HOME/.config/gtk-3.0 gtk-3.0
mkdir -p $HOME/.config/kitty && stow -v -t $HOME/.config/kitty kitty
mkdir -p $HOME/.config/polybar && stow -v -t $HOME/.config/polybar polybar
rm -r $HOME/.config/rofi && mkdir -p $HOME/.config/rofi && stow -v -t $HOME/.config/rofi rofi

cd $HOME/repos/Arch_Linux/shell-files/
ln picom.conf $HOME/.config/picom.conf

rm $HOME/.poshthemes/tj-dracula.omp.json
rm $HOME/.gitconfig
rm $HOME/.tmux.conf
rm $HOME/.zshrc
rm $HOME/.zsh_aliases
rm $HOME/.bashrc
rm $HOME/.bash_aliases
rm $HOME/.vimrc

clearwait
blue "Links simbólicos de arquivos"
ln $HOME/repos/Arch_Linux/stow/oh-my-posh/tj-dracula.omp.json $HOME/.poshthemes/tj-dracula.omp.json
ln $HOME/repos/Arch_Linux/stow/git/.gitconfig $HOME/.gitconfig
ln $HOME/repos/Arch_Linux/stow/starship/starship.toml $HOME/.config/starship.toml
ln $HOME/repos/Arch_Linux/shell-files/dracula/.bashrc $HOME/.bashrc
ln $HOME/repos/Arch_Linux/shell-files/dracula/.zshrc $HOME/.zshrc
ln $HOME/repos/Arch_Linux/shell-files/dracula/.bash_aliases $HOME/.bash_aliases
ln $HOME/repos/Arch_Linux/shell-files/dracula/.zsh_aliases $HOME/.zsh_aliases
ln $HOME/repos/Arch_Linux/shell-files/dracula/.vimrc $HOME/.vimrc
rm -r $HOME/Pictures && mkdir -p $HOME/Pictures && cd $HOME/repos/Arch_Linux && stow -v -t $HOME/Pictures wallpapers

mkdir -p $HOME/.vim/pack/themes/start
cd $HOME/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula

sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd

title_green "Instalação concluída."
