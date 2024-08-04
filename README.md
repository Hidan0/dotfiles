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

In my terminal setup, I've got `alacritty` for speed, `zsh` with `zinit` for extra
features as plugins, and `oh-my-posh` for a stylish prompt.

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
yay -S alacritty zsh oh-my-posh neovim yarn npm wget luarocks ripgrep fd \
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

The theme I use is [_gruvbox material_](https://github.com/sainnhe/gruvbox-material).

- Icon theme `gruvbox-material-icon-theme-git`
- GTK theme: `gruvbox-material-gtk-theme-git`
- Fonts: `nerd-fonts-git` (install it later, it takes some time)

```
yay -S nwg-look gruvbox-material-gtk-theme-git gruvbox-material-icon-theme-git \
       nerd-fonts-git noto-fonts-emoji
```

## Pipewire noise filter

For noise suppression, I've integrated `noise-suppression-for-voice` plugin ([git](https://github.com/werman/noise-suppression-for-voice)).

Link the `pipewire` dir and make a symbolic link of `*.service` file into `.config/systemd/user`.

Reload systemd user unit files:

```
$ systemctl --user daemon-reload
```

Enable the created systemd service:

```
$ systemctl --user enable pipewire-input-filter-chain.service
```

Reference: https://medium.com/@gamunu/linux-noise-cancellation-b9f997f6764d

```
yay -S noise-suppression-for-voice
```

## Other application that I may need

```
yay -S okular webcord spotify-launcher telegram-desktop ranger
```
