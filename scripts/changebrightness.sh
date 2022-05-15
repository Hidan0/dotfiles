#!/bin/bash

function send_notification() {
	brightness=$(printf "%.0f\n" $(xbacklight -get))
	dunstify -a "changebrightness" -u low -r 9991 -h int:value:"$brightness" "Brightness: $brightness%" -t 2000
}

case $1 in
  up)
    pkexec brillo -A 5
    send_notification
    ;;
  down)
    pkexec brillo -U 5
    send_notification
    ;;
esac
