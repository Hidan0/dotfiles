# Replicate system

In this section I'm gonna illustrate how to duplicate my system.

## SO installation

Download and flash ArchLinux ISO and run `archinstall` to perform the guided
installation. The configuration should look like something like this:

- Bootloader: Grub
- Unified kernel images: False
- Swap: True
- Hostname: hidan0pc
- Profile: Minimal
- Audio: Pipewire
- Kernels: linux-lts
- Network configuration: Use NetworkManager

## AUR

To install `yay`, just follow the steps inside the [GitHub page](https://github.com/Jguer/yay).

## Hyprland

`hyprland` is my the tiling WM of choice, along with the packages that make up the main
ecosystem `hypridle hyprlock hyprpaper xdg-desktop-portal-hyprland`. The other must
have aspects of a DE are provided by `waybar wofi mako polkit-kde-agent wl-clipboard`.

QT waylandy support is provided by `qt5-wayland qt6-wayland`, while the screenshots
utility is obtained from the combination of the following packages plus a script:
`swappy slurp grim`.

- Application launcher: `wofi`
- Automatically mount disks with `udiskie`
- Applet for NetworkManager `nm-applet`
- Bluetooth settings: `blueberry`
- Audio settings: `pavucontrol`

---

```
yay -S hyprland hypridle hyprlock xdg-desktop-portal-hyprland waybar \
       hyprpaper swappy slurp grim qt5-wayland qt6-wayland wl-clipboard \
       wofi mako polkit-kde-agent udiskie network-manager-applet blueberry  \
       pavucontrol thunar
```

## Development Environment

### Terminal and shell

In my terminal setup, I've got `alacritty` for speed, `zsh` with `oh-my-zsh` for extra
features, and `starship` for a stylish prompt.

To set `zsh` as the [default shell](https://wiki.archlinux.org/title/Command-line_shell#Changing_your_default_shell) run:

```
$ chsh -s /full/path/to/shell
```

Some commands like `ls` are being replaced by some new programs, just run `/scripts/install-modern-tool.sh`.

### Editor

In my editor setup, I rely on Neovim for its versatility. To enhance it, I've integrated
external software. This ensures a smooth and efficient development experience and
support for plugins.

### Workspace management

For workspace management, I've set up `tmux` paired with `tmp` (Tmux Plugin Manager) for
plugin management. To session handling, I rely on [Tmux-Sessionizer](https://github.com/jrmoulton/tmux-sessionizer).

To install `tmp` just follow the [GitHub page](https://github.com/tmux-plugins/tpm).
To install `tms` run `cargo install tmux-sessionizer` (you need rust and cargo).

Reload `tmux` and press `prefix` + `I` to fetch and install plugins:

```
# to reload
tmux source ~/.tmux.conf
```

---

```
yay -S alacritty zsh starship oh-my-zsh-git neovim yarn npm wget luarocks ripgrep fd \
       tmux pfetch zk libqalculate
```

## NVIDIA graphics drivers

```
yay -S nvidia-lts nvidia-utils linux-headers
```

### Enable DRM kernel mode setting

You need `linux-headers` first.

In `/etc/mkinitcpio.conf` add `nvidia nvidia_modeset nvidia_uvm nvidia_drm` to your
`MODULES`.

Run `# mkinitcpio -P` to generate the required files.

Add a new line to `/etc/modprobe.d/nvidia.conf` (make it if it does not exist) and add
the line `options nvidia-drm modeset=1`.

## Bluetooth support

Just install `bluez bluez-utils` and enable/start `bluetooth.service`.

```
yay -S bluez bluez-utils
```

## Theme, cursors and stuff

Use `nwg-look` to set themes and GTK related stuff.

The theme I use is _Catppuccin mocha_.

- Icon theme `papirus-icon-theme` + [catppuccin theme](https://github.com/catppuccin/papirus-folders)
- GTK theme: `catppuccin-gtk-theme-mocha`
- Fonts: `nerd-fonts-git ttf-jetbrains-mono-nerd ttf-jetbrains-mono`

```
yay -S nwg-look papirus-icon-theme catppuccin-gtk-theme-mocha nerd-fonts-git \
       ttf-jetbrains-mono-nerd ttf-jetbrains-mono noto-fonts-emoji
```

## TODO: Pipewire noise filter

**noise-suppression-for-voice** is required ([git](https://github.com/werman/noise-suppression-for-voice), [AUR](https://aur.archlinux.org/packages/noise-suppression-for-voice)).

The scripts copies the _systemd unit_ file in the configuration directory and enables the service.

Reference: https://medium.com/@gamunu/linux-noise-cancellation-b9f997f6764d

## TODO other

```
yay -S okular
```
