#!/bin/bash

current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ $current_layout == "us" ]; then
    setxkbmap -layout it 
    echo "Switched to It"
else
    setxkbmap -layout us -variant intl
    echo "Switched to Us Intl"
fi

