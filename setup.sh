set -e
sudo dnf update -y

sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y makecache
sudo dnf install -y akmod-nvidia

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub app.zen_browser.zen
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub md.obsidian.Obsidian

sudo dnf install -y steam htop 

sudo dnf install jetbrains-mono-fonts
sudo dnf install fastfetch
sudo dnf install nodejs npm
sudo dnf install docker docker-compose
sudo dnf install golang

sudo dnf install nvim
sudo dnf install kitty

git config --global user.name = "trobukan"
git config --global user.email = "trobukan@gmail.com"
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global pull.rebase false
git config --global core.editor "nvim"