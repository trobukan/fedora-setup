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

# > | NVIDIA drivers (Optional) | <
read -p "Do you want to install NVIDIA drivers? (y/N): " -n 1 -r REPLY
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing NVIDIA drivers..."
    sudo dnf install -y \
        akmod-nvidia \
        xorg-x11-drv-nvidia-cuda \
        kernel-devel \
        kernel-headers

    echo -e "\n Reboot is required for NVIDIA drivers to take effect.\n"
else
    echo "NVIDIA drivers installation skipped."
fi

# > | Flatpak setup | <
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub app.zen_browser.zen

# > | Useful packages | <
sudo dnf install -y htop fastfetch nodejs npm docker docker-compose golang neovim kitty stow zsh zoxide bat btop luarocks lua @development-tools

# > | Set zsh as default shell | <
if command -v zsh &>/dev/null; then
    chsh -s "$(command -v zsh)"
    echo "Zsh set as default shell. Logout/relogin to apply."
fi

# > | Font | <
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
wget -P "$FONT_DIR" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o "$FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR"
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

    if [ ! -d ~/dotfiles/.git ]; then
        git clone --recurse-submodules git@github.com:trobukan/dotfiles.git ~/dotfiles/
    fi

    cd ~/dotfiles/
    for folder in *; do
        if [ -d "$folder" ] && [ "$folder" != ".git" ]; then
            stow "$folder"
        fi
    done

    echo "Dotfiles successfully configured!"
else
    echo "Dotfiles setup skipped."
fi
