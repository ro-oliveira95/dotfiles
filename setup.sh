#!/bin/bash

GIT_EMAIL="example@gmail.com"
GIT_NAME="NAME"
GIT_CREATE_SSH=true

# ---------- Gnome ----------
sudo dnf install -y gnome-tweaks

# Theme
wget -P /usr/tmp https://github.com/dracula/gtk/archive/master.zip
mkdir -p $HOME/.themes
unzip /usr/tmp/master.zip -d $HOME/.themes
mv $HOME/.themes/gtk-master $HOME/.themes/Dracula

gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

# Icons
wget -P /usr/tmp https://github.com/dracula/gtk/files/5214870/Dracula.zip
mkdir -p $HOME/.icons
unzip /usr/tmp/Dracula.zip -d $HOME/.icons

gsettings set org.gnome.desktop.interface icon-theme "Dracula"

# TODO: load gsettings, keyboard shortcuts

# ----- Package manager -------
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/rneto/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo yum groupinstall 'Development Tools'

# dnf from community, Flatpak, ...

# ---------- Terminal ----------
# Terminator + zsh + oh-my-zsh
sudo dnf install -y terminator
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Starship
mkdir $HOME/.fonts && \
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraMono.zip -P /tmp && \
	unzip /tmp/FiraMono.zip -d $HOME/.fonts
curl -sS https://starship.rs/install.sh | sh


# Atuin
brew install atuin
echo 'eval "$(atuin init zsh)"' >> ~/.zshrc

# ---------- Git -----------
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME

if [ "$GIT_CREATE_SSH" = true ]; then
	ssh-keygen -t ed25519 -C $GIT_EMAIL
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub  # --> Add key to Github			
fi

# ---------- CLI apps ----------
sudo dnf install -y micro
sudo dnf install -y stow
# TODO: ripgrep, etc...

# ---------- GUI apps ----------
# Brave
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser
# TODO: spotify, todoist, obsidian, raindrop
