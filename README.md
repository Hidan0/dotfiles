# Hidan0's Dotfiles

This dotfiles are not "plug and play", they are meant for personal use. You can of course use them, but to make them work you'll probably need some debugging.

## Table of Contents

- [Current setup](#current-setup)
  - ["Hyprland"](#hyprland)
- [Scripts](#Scripts)
  - [Menus](#menus)
  - [Pipewire noise filter](#pipewire-noise-filter)

## Current setup

> CURRENTLY TRYING WAYLAND WITH HYPRLAND

- OS: [Arcolinux](https://arcolinux.com/)
- Window Manager: awesome
- Bar: wibar
- Compositor: picom (AUR: [picom-jonaburg-git](https://aur.archlinux.org/packages/picom-jonaburg-git))
- Sound: pipewire
- Shell: zsh + starship
- Console: alacritty
- Application launcher: dmenu + rofi
- Lockscreen: betterlockscreen
- Editor: nvim
- Theme: [Catppuccin](https://github.com/catppuccin/catppuccin)
- Cursor: breeze (AUR: [breeze-snow-cursor-theme](https://aur.archlinux.org/packages/breeze-snow-cursor-theme))
- Wallpaper: evening-sky from [catppuccin wallpapers](https://github.com/catppuccin/wallpapers)

### Hyprland

Dependences:

```
yay -S hyprland-dev waybar-hyprland-git xdg-desktop-portal-hyprland-git swaylock-effects swappy slurp swayidle grim swaybg wl-clipboard wofi qt5-wayland qt6-wayland polkit-kde-authentication-agent-1
```

## Scripts

### Menus

**Rofi** is required.

- `powermenu.sh` display a simple powermenu using rofi.

Other menus using rofi:

- rofi-calc ([git](https://github.com/svenstaro/rofi-calc))
- rofi-emoji ([git](https://github.com/Mange/rofi-emoji))

### Pipewire noise filter

**noise-suppression-for-voice** is required ([git](https://github.com/werman/noise-suppression-for-voice), [AUR](https://aur.archlinux.org/packages/noise-suppression-for-voice)).

The scripts copies the _systemd unit_ file in the configuration directory and enables the service.

Reference: https://medium.com/@gamunu/linux-noise-cancellation-b9f997f6764d
