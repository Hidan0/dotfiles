#! /bin/bash

sudo pacman -S --noconfirm --needed pipewire
sudo pacman -S --noconfirm --needed pipewire-media-session
sudo pacman -S --noconfirm --needed pipewire-alsa
sudo pacman -S --noconfirm --needed pipewire-media-session
sudo pacman -S --noconfirm --needed pipewire-jack
sudo pacman -S --noconfirm --needed pipewire-zeroconf

sudo pacman -S --noconfirm --needed pipewire-pulse
sudo pacman -S --noconfirm --needed blueberry
sudo pacman -S --noconfirm --needed pavucontrol
sudo systemctl enable bluetooth.service

echo "Reboot now"

