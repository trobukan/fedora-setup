#!/bin/bash
set -e

# > | System update | <
sudo dnf update -y

# > | RPM Fusion repositories | < 
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# > | Refresh DNF cache | <
sudo dnf makecache

# > | NVIDIA drivers | <
sudo dnf install -y akmod-nvidia kernel-devel kernel-headers

# > | Flatpak setup | < 
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --noninteractive flathub app.zen_browser.zen

# > | Useful packages | <
sudo dnf install -y htop fastfetch nodejs npm docker docker-compose golang neovim kitty stow git zsh

# > | Font | <
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
wget -p "$FONT_DIR" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o "$FONT_DIR/JetBrainsMono.zip"
fc-cache -fv

# > | Wallpaper | <
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
mkdir -p "$WALLPAPER_DIR"

cp ~/dotfiles/wallpapers/wallpaper.jpg "$WALLPAPER_DIR"
if command -v plasma-apply-wallpaperimage &>/dev/null; then
  plasma-apply-wallpaperimage "$WALLPAPER_DIR/wallpaper.jpg"
fi

# > | Dotfiles setup (Optional) | <
echo -e "\n--- Dotfiles setup ---"
read -p "Do you want to clone and configure your dotfiles? (y/N): " -n 1 -r REPLY
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Starting dotfiles setup..."
  mkdir -p ~/dotfiles

  rm -rf ~/.config/fastfetch ~/.config/kitty ~/.config/nvim ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/.config/kglobalshortcutsrc
  if [ ! -d ~/dotfiles/.git ]; then
    git clone --recurse-submodules https://github.com/your-username/your-dotfiles-repo.git ~/dotfiles/
  fi

  cd ~/dotfiles/
  stow .
  echo "Dotfiles successfully configured!"
else
  echo "Dotfiles setup skipped."
fi
