#!/usr/bin/env bash 

_ps=(swww swayidle nm-applet waybar mako polkit-kde-authentication-agent-1)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

swww init &
swww img $HOME/Documents/JStreet_edit.jpg &

nm-applet --indicator &

mako &

exec waybar -c $HOME/.config/hypr/waybar/config.json -s $HOME/.config/hypr/waybar/style.css &

/usr/lib/polkit-kde-authentication-agent-1 &

