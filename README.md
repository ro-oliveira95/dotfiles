# Dotfiles + OS config (Fedora)

## Requirements

OS: Linux Fedora
Packages:
* stow

## Workflow
```bash
# Config OS (gnome, terminal, apps, etc.)
chmod +x setup.sh
./setup.sh
# Config dotfiles
stow */ -t $HOME
````
