#!/usr/bin/env bash 

_ps=(nm-applet waybar mako udiskie hypridle hyprpaper polkit-kde-authentication-agent-1)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

nm-applet --indicator &
mako &
exec waybar -c $HOME/.config/hypr/waybar/config.json -s $HOME/.config/hypr/waybar/style.css &
/usr/lib/polkit-kde-authentication-agent-1 &
udiskie &
hypridle &
hyprpaper &
