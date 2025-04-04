#!/usr/bin/bash
sudo pacman -Syu
sudo pacman -S toilet zsh --noconfirm
sudo pacman -S --needed git base-devel

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

clearwait
title_green "Atualizando o sistema..."
sudo pacman -S curl wget iwd neofetch redshift \
  nano neovim net-tools git \
  cmake ninja clang pkgconf xclip xsel \
  noto-fonts noto-fonts-emoji ttf-liberation \
  gst-libav gst-plugins-good gst-plugins-bad \
  gst-plugins-ugly ffmpeg gstreamer \
  kitty xdg-desktop-portal fzf docker docker-compose \
  zip unzip p7zip unrar fontconfig playerctl \
  tar gzip firefox feh man-db nitrogen \
  flatpak python3 python-pip vlc mpv cmatrix \
  obs-studio zsh tmux btop locate acpi maim \
  bat nm-connection-editor openssh ufw dmenu \
  power-profiles-daemon cliphist dunst network-manager-applet \
  polybar timidity++ powertop xfce4-settings \
  glib2 base-devel bluez blueman bluez-utils \
  pavucontrol wpa_supplicant obsidian scrot \
  gimp eog cargo scdoc inetutils iniparser pyright \
  font-manager xdotool xorg-xwininfo xfwm4 \
  thunar xfce4-power-manager ristretto mousepad \
  picom orage xfce4-taskmanager xfce4-pulseaudio-plugin \
  scrcpy rofi shotcut xorg-xrandr ranger \
  lxqt-config xorg xorg-xdm ttf-dejavu --noconfirm

flatpak install discord

clearwait
green "Pacotes instalados."

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
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd $HOME/Downloads
sudo rm -r yay
yay -Syu

sudo usermod -aG docker $USER

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
mkdir -p $HOME/development && cd $HOME/Downloads
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz
tar -xf $HOME/Downloads/flutter_linux_3.27.1-stable.tar.xz -C $HOME/development/
rm flutter_linux_3.27.1-stable.tar.xz
sudo rm -r Dracula && sudo rm -r snapd

powerprofilesctl set performance

clearwait
blue "Instalando pacotes yay..."
yay -S --noconfirm ly cava google-chrome visual-studio-code-bin make deluge deluge-gtk android-studio postman-bin
yay -S upscayl-bin tdf youtube-music i3-gaps i3lock-color

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
mkdir -p $HOME/.config/nitrogen && stow -v -t $HOME/.config/nitrogen nitrogen
rm -r $HOME/.config/rofi && mkdir -p $HOME/.config/rofi && stow -v -t $HOME/.config/rofi rofi

cd $HOME/repos/Arch_Linux/shell-files/
ln picom.conf $HOME/.config/picom.conf

rm $HOME/.poshthemes/tj-dracula.omp.json && rm $HOME/.gitconfig && rm $HOME/.tmux.conf && rm $HOME/.zshrc && rm $HOME/.zsh_aliases && rm $HOME/.bashrc && rm $HOME/.bash_aliases && rm $HOME/.vimrc

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

sleep 2
source $HOME/.bashrc
sleep 2

brew install eza glow tldr fd git-delta yazi zoxide
brew install jesseduffield/lazygit/lazygit

systemctl --user enable pipewire.service
sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl enable ly.service

xfconf-query -c xsettings -p /Net/ThemeName -s "Dracula"
xfconf-query -c xsettings -p /Net/IconThemeName -s "dracula-dark"
xfconf-query -c xfwm4 -p /general/theme -s "Dracula" --create -t string
xfconf-query -c xfwm4 -p /general/theme -s "Dracula"
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "Bibata-Modern-Ice"
xfconf-query -c xsettings -p /Gtk/FontName -s "JetBrainsMono NFM 11"


title_green "Instalação concluída."

sudo reboot now