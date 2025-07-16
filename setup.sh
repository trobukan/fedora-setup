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