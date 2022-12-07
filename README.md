 # Hidan0's Dotfiles

 This dotfiles are not "plug and play", they are meant for personal use. You can of course use them, but to make them work you'll probably need some debugging.

## Table of Contents
- [Current setup](#current-setup)
- ["Installation" script](#%E2%80%9Cinstallation%E2%80%9D-script)
- [Scripts](#Scripts)
  - [Menus](#menus)
  - [Pipewire noise filter](#pipewire-noise-filter)

## Current setup

- OS: [Arcolinux](https://arcolinux.com/)
- Window Manager: awesome
- Bar: wibar
- Compositor: picom (AUR: [picom-jonaburg-git](https://aur.archlinux.org/packages/picom-jonaburg-git))
- Sound: pipewire
- Shell: zsh + starship
- Console: alacritty
- Application launcher: dmenu + rofi
- Editor: helix
- Theme: [Catppuccin](https://github.com/catppuccin/catppuccin)
- Cursor: breeze (AUR: [breeze-snow-cursor-theme](https://aur.archlinux.org/packages/breeze-snow-cursor-theme))
- Wallpaper: evening-sky from [catppuccin wallpapers](https://github.com/catppuccin/wallpapers)

## "Installation" script

The "installation" script is `link_dot.lua`; this is a really bad written script that creates a symbolic link between the content of the repository and the home directory.
The content of `config` will be linked at `$HOME/.config/`(Ex: `$HOME/.config/alacritty -> .dotfiles/config/alacritty`).
If the file/dir is already present (symbolic link included) a new link will be created, the old one will be renamed (yeah it's pretty bad).

## Scripts

### Menus

**Rofi** is required.

- `powermenu.sh` display a simple powermenu using rofi.

Other menus using rofi:
- rofi-calc ([git](https://github.com/svenstaro/rofi-calc))
- rofi-emoji ([git](https://github.com/Mange/rofi-emoji))

### Pipewire noise filter

**noise-suppression-for-voice** is required ([git](https://github.com/werman/noise-suppression-for-voice), [AUR](https://aur.archlinux.org/packages/noise-suppression-for-voice)).

The scripts copies the *systemd unit* file in the configuration directory and enables the service.

Reference: https://medium.com/@gamunu/linux-noise-cancellation-b9f997f6764d

