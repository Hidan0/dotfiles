#!/bin/bash

# yay -S noise-suppression-for-voice
# is required

cp -i $HOME/.dotfiles/config/pipewire/pipewire-input-filter-chain.service $HOME/.config/systemd/user/
systemctl --user deamon-reload
systemctl --user enable pipewire-input-filter-chain.service
systemctl --user status pipewire-input-filter-chain.service
