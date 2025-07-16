set -e
sudo dnf update -y

sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install makecache
sudo dnf install -y akmod-nvidia

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo