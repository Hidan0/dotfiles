#! /bin/bash

chosen=$(printf " Power Off\n Restart\n Suspend\n Log out" | rofi -dmenu -i)

case "$chosen" in
	" Power Off") systemctl poweroff;;
	" Restart") systemctl reboot;;
	" Suspend") systemctl suspend;;
  " Log out") bspc quit;;
	*) exit 1 ;;
esac
