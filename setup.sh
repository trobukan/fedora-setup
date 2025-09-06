#!/bin/bash

set -e
sudo dnf update -y

sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y makecache
sudo dnf install -y akmod-nvidia

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub app.zen_browser.zen

sudo dnf install -y htop fastfetch jetbrains-mono-fonts nodejs npm docker docker-compose golang nvim kitty stow

plasma-apply-wallpaperimage ./wallpapers/wallpaper.jpg

