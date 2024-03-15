#!/usr/bin/env bash 

swayidle -w timeout 300 '$HOME/.config/hypr/scripts/lockscreen.sh' \
            timeout 600 'systemctl suspend' \
            before-sleep '$HOME/.config/hypr/scripts/lockscreen.sh' &
