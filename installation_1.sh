#!/usr/bin/bash
set -e

msg_color() {
  clear
  echo -e "\n\033[$1m$2\033[0m\n"
  sleep 2
}

sudo pacman -S wget git tmux curl nano eog \
  fastfetch stow flatpak nwg-look zsh gnome-disk-utility \
  cpupower cava cronie nodejs npm kitty --noconfirm

msg_color "34" "Instalando o Oh My ZSH..."
REPO_DIR="$HOME/Development/Arch_Linux/"
TERMINALS_DIR="$REPO_DIR/packages/"
CUSTOMIZATION_DIR="$REPO_DIR/customization"

rm -rf "$HOME/.oh-my-zsh/"
rm -rf "$HOME/.poshthemes/"
rm -rf "$HOME/.tmux/"
rm -rf "$HOME/.themes/Dracula/"
rm -rf "$HOME/.local/share/icons/dracula/"
rm -rf "$HOME/.local/share/icons/dracula-light/"
rm -rf "$HOME/.local/share/icons/dracula-dark/"
rm -rf "$HOME/.zshrc"
rm -rf "$HOME/.zsh_aliases"

cd "$TERMINALS_DIR" && ./oh_my_zsh_install.sh || exit

msg_color "34" "Instalando o Oh My Posh..."
sudo wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir -p "$HOME/.poshthemes"
wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O "$HOME/.poshthemes/themes.zip"
unzip -q "$HOME/.poshthemes/themes.zip" -d "$HOME/.poshthemes"
rm "$HOME/.poshthemes/themes.zip"
ln -sf "$CUSTOMIZATION_DIR/zsh/tj-dracula.omp.json" "$HOME/.poshthemes/tj-dracula.omp.json"

msg_color "34" "Criando diretórios..."
mkdir -p "$HOME/Development" "$HOME/.icons" "$HOME/.themes" "$HOME/scripts"

msg_color "34" "Instalando fontes..."
FONT_DIR="/usr/share/fonts/"
LOCAL_FONT_DIR="$HOME/.local/share/fonts/"
mkdir -p $LOCAL_FONT_DIR
sudo mkdir -p $FONT_DIR
cd "$REPO_DIR/fonts" || exit
sudo cp JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf "$FONT_DIR"
sudo cp JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf "$LOCAL_FONT_DIR"
sudo cp JetBrainsMonoNerdFontMono-*.ttf "$FONT_DIR"
sudo cp JetBrainsMonoNerdFontMono-*.ttf "$LOCAL_FONT_DIR"
sudo cp FantasqueSansMNerdFont-Regular.ttf "$FONT_DIR"
sudo cp FantasqueSansMNerdFont-Regular.ttf "$LOCAL_FONT_DIR"
sudo cp FantasqueSansMNerdFontMono-Regular.ttf "$FONT_DIR"
sudo cp FantasqueSansMNerdFontMono-Regular.ttf "$LOCAL_FONT_DIR"

msg_color "34" "Instalando logo-ls..."
cp "$CUSTOMIZATION_DIR/bash/logo-ls_Linux_x86_64.tar.gz" "$HOME/Downloads"
cd "$HOME/Downloads" || exit
tar -zxf logo-ls_Linux_x86_64.tar.gz
sudo cp logo-ls_Linux_x86_64/logo-ls /usr/local/bin
rm -r logo-ls_Linux_x86_64 logo-ls_Linux_x86_64.tar.gz

msg_color "34" "Ativando o acesso aos apps Flatpak..."
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

msg_color "34" "Instalando o HomeBrew..."
cd "$REPO_DIR/packages" && ./brew_install.sh || exit

msg_color "34" "Configurando Tmux..."
git clone --quiet https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
ln -sf "$CUSTOMIZATION_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
tmux new-session -d -s "dev"
tmux source "$HOME/.tmux.conf"
tmux kill-session -t "dev"

msg_color "34" "Configurando HomeBrew no shell..."
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' | tee -a "$HOME/.bashrc" "$HOME/.zshrc" >/dev/null

cd "$HOME/Development/Arch_Linux/stow" || exit

declare -a configs=(
  "cava"
  "lazygit"
  "gtk-3.0"
  "gtk-4.0"
  "kitty"
)

for config in "${configs[@]}"; do
  target_dir="$HOME/.config/$config"
  if [ -e "$target_dir" ]; then
    rm -rf "$target_dir"
  fi
  mkdir -p "$target_dir"
  stow -v -t "$target_dir" "$config"
done

if [ -e "$HOME/Xresources" ]; then
  rm "$HOME/Xresources"
fi
ln -s "$HOME/Development/Arch_Linux/stow/Xresources" "$HOME/Xresources"

if [ -e "$HOME/.xprofile" ]; then
  rm "$HOME/.xprofile"
fi
ln -s "$HOME/Development/Arch_Linux/stow/.xprofile" "$HOME/.xprofile"

if [ -e "$HOME/Xauthority" ]; then
  rm "$HOME/Xauthority"
fi
ln -s "$HOME/Development/Arch_Linux/stow/Xauthority" "$HOME/Xauthority"

cd "$HOME/Development/Arch_Linux/" || exit
mkdir -p "$HOME/scripts" && stow -v -t "$HOME/scripts" scripts

cd "$HOME/Downloads/" || exit
wget -q https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
mv gtk-master Dracula
mv Dracula "$HOME/.themes"
rm master.zip
cd "$HOME/Downloads" || exit
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme || exit
./install.sh -n dracula
cd ..
sudo rm -r Tela-icon-theme

files=(
  "$HOME/.zshrc:$HOME/Development/Arch_Linux/customization/zsh/.zshrc"
  "$HOME/.zsh_aliases:$HOME/Development/Arch_Linux/customization/zsh/.zsh_aliases"
  "$HOME/.gitconfig:$HOME/Development/Arch_Linux/customization/git/.gitconfig"
)

for file in "${files[@]}"; do
  target="${file%%:*}"
  source="${file##*:}"
  if [ -e "$target" ]; then
    rm "$target"
  fi
  ln -s "$source" "$target"
done
