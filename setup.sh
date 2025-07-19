set -e
force_link() {
  local source="$1"
  local target="$2"

  if [ -e "$target" ] || [ -L "$target" ]; then
    rm -rf "$target"
  fi
  ln -sf "$source" "$target"
}

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

sudo dnf install -y steam htop fastfetch jetbrains-mono-fonts nodejs npm docker docker-compose golang nvim kitty

git config --global user.name = "trobukan"
git config --global user.email = "trobukan@gmail.com"
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global pull.rebase false
git config --global core.editor "nvim"

git clone git@github.com:trobukan/dotfiles.git
DOTFILES="$(realpath ./fedorakde-dotfiles)"
BASHRC="$DOTFILES/.bashrc"
KITTY="$DOTFILES/.config/kitty"
FASTFETCH="$DOTFILES/.config/fastfetch"

forcelink "$BASHRC" "$HOME/.bashrc"
forcelink "$KITTY" "$HOME/.config/kitty"
forcelink "$FASTFETCH" "$HOME/.config/fastfetch"

plasma-apply-wallpaperimage ./wallpapers/em-roji.jpg
