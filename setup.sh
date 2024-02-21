#!/bin/bash

GIT_EMAIL="example@gmail.com"
GIT_NAME="NAME"
GIT_CREATE_SSH=true

# ---------- Gnome ----------
sudo dnf install -y gnome-tweaks
# TODO: set theme, load gsettings, keyboard shortcuts

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

# TODO: Atuin

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
