#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

$HOME/.config/polybar/launch.sh &
$HOME/.screenlayout/display.sh

# feh --bg-scale $HOME/Pictures/Wallpapers/astronaut-and-jellyfish-wallpaper-1920x1080_48.jpg &
feh --bg-scale $HOME/Pictures/Wallpapers/dark-side.jpg &
#dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
xsetroot -cursor_name left_ptr &
run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &

run nm-applet &
run xfce4-power-manager &
run xfce4-screensaver &
numlockx on &
blueberry-tray &
picom --experimental-backends --config $HOME/.config/bspwm/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
xinput --map-to-output 'CUST0000:00 04F3:2A81 Stylus Pen (0)' eDP-1
xinput --map-to-output 'CUST0000:00 04F3:2A81 Stylus Eraser (0)' eDP-1
# run volumeicon &
flameshot &

