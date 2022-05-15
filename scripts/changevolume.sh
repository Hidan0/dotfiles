#!/bin/bash

function send_notification() {
  volume=$(amixer get Master | grep 'Front Left: ' | egrep -o '[0-9]{1,3}%')
	dunstify -a "changevolume" -u low -r 9991 -h int:value:"$volume" "Volume: $volume" -t 2000
}

case $1 in
  up)
    amixer set Master 10%+
    send_notification
    ;;
  down)
    amixer set Master 10%-
    send_notification
    ;;
esac
