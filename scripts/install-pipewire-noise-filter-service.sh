#!/bin/bash

# yay -S noise-suppression-for-voice
# is required

cp -i $HOME/.dotfiles/config/pipewire/pipewire-input-filter-chain.service $HOME/.config/systemd/user/
