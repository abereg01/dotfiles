#!/bin/bash
# scripts/backup-packages.sh

# Official repositories
pacman -Qqen > $HOME/dotfiles/packages/pacman.txt

# AUR packages
pacman -Qqem > $HOME/dotfiles/packages/aur.txt

# Optional: Include package descriptions
pacman -Qe | awk '{print $1 " # " $2}' > $HOME/dotfiles/packages/packages-with-descriptions.txt
