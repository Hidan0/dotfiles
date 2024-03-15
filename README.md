# Hidan0's Dotfiles

This dotfiles are not "plug and play", they are meant for personal use. You can of course use them, but to make them work you'll probably need some debugging.

## Current setup

### Terminal and shell

- Terminal: Alacritty
- Shell: zsh + starship + oh-my-zsh
- Editor: nvim
- Workspaces: tmux + tmux-sessionizer + tmp

### Hyprland

Main:

```
yay -S hyprland waybar-hyprland-git xdg-desktop-portal-hyprland polkit-kde-agent \
       qt5-wayland qt6-wayland wl-clipboard wofi mako
```

Lock screen and idle:

```
yay -S swaylock-effects swayidle nwg-bar
```

Background image and screenshot utilities:

```
yay -S swww swappy slurp grim
```

Other utilities:

```
yay -S brillo pavucontrols blueberry
```

### Pipewire noise filter

**noise-suppression-for-voice** is required ([git](https://github.com/werman/noise-suppression-for-voice), [AUR](https://aur.archlinux.org/packages/noise-suppression-for-voice)).

The scripts copies the _systemd unit_ file in the configuration directory and enables the service.

Reference: https://medium.com/@gamunu/linux-noise-cancellation-b9f997f6764d
