#!/bin/bash
set -e

# Ensure sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (sudo ./fedora-setup.sh)"
  exit
fi

echo "==> Updating system..."
dnf update -y

echo "==> Installing core tools..."
dnf install -y fish neovim git curl gcc wget unzip stow \
    network-manager-applet blueman rofi dunst picom udiskie \
    polkit-gnome libnotify ripgrep starship eza

echo "==> Installing pywal and ricing tools..."
dnf install -y python3-pywal

echo "==> Installing btrfs + snapper for rollback..."
dnf install -y btrfs-progs snapper grub-btrfs snapper-gui
snapper -c root create-config /
systemctl enable --now snapper-timeline.timer snapper-cleanup.timer

echo "==> Setting up grub snapshot boot support..."
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

echo "==> Installing Hyprland + waybar + kitty..."
dnf copr enable -y zirix/hyprland
dnf install -y hyprland hyprpaper waybar kitty

echo "==> Installing BSPWM + sxhkd..."
dnf install -y bspwm sxhkd

echo "==> Installing KDE Plasma (optional, for app support)..."
dnf groupinstall -y "KDE Plasma Workspaces"

echo "==> Installing display managers..."
dnf install -y gdm sddm
systemctl enable gdm --now

echo "==> Installing AD and Evolution integration..."
dnf install -y realmd sssd adcli oddjob oddjob-mkhomedir samba-common-tools \
    evolution evolution-ews

echo "==> Enabling polkit agents and gesture support..."
dnf install -y gnome-keyring gnome-control-center libinput-tools

echo "==> Installing swww..."
dnf copr enable -y lloydde/swww
dnf install -y swww

echo "==> Installing development tools..."
dnf groupinstall -y "Development Tools"
dnf install -y podman docker-compose direnv

echo "==> Final touches..."
usermod -aG wheel $(logname)
chsh -s /usr/bin/fish $(logname)

echo "==> Done. Reboot to continue setup!"

