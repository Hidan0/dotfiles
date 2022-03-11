#!/usr/bin/env sh

# More info : https://github.com/jaagr/polybar/wiki

# Install the following applications for polybar and icons in polybar if you are on ArcoLinuxD
# awesome-terminal-fonts
# Tip : There are other interesting fonts that provide icons like nerd-fonts-complete
# --log=error
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

monitors=$(xrandr | grep "HDMI-1 connected")

if [ -n "$monitors" ]; then
    polybar catppuccin -c ~/.config/polybar/polybar.ini &
    polybar catppuccin2 -c ~/.config/polybar/polybar.ini &
else
    polybar catppuccin3 -c ~/.config/polybar/polybar.ini &
fi
;;
