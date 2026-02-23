#!/usr/bin/env bash

theme=$1
themes_dir="$HOME/.config/dunst/themes"
dunstrc="$HOME/.config/dunst/dunstrc"

# Ask theme using dmenu if not passed or invalid
if [[ -z "$theme" || (! -f "$themes_dir/$theme.conf" && ! -f "$themes_dir/$theme.dunstrc") ]]; then
    theme=$(ls "$themes_dir" | sed 's/\.conf$\|\.dunstrc$//' | dmenu -p "Select Dunst Theme:")
    
    # Handle cancel (ESC) from dmenu
    if [[ -z "$theme" ]]; then
        notify-send "Dunst" "No theme selected." -t 2000
        exit 1
    fi
fi

# Check for valid theme files
if [[ -f "$themes_dir/$theme.conf" ]]; then
    cp "$themes_dir/$theme.conf" "$dunstrc"
elif [[ -f "$themes_dir/$theme.dunstrc" ]]; then
    cp "$themes_dir/$theme.dunstrc" "$dunstrc"
else
    notify-send "Dunst" "Theme not found: $theme" -t 2000
    exit 1
fi

# Restart dunst (delay notify-send to allow new instance to load)
killall dunst
sleep 0.2 && dunst &  # Delay ensures notify-send is picked up

# Give dunst a second to initialize
sleep 0.2
notify-send "Dunst" "Loaded theme: $theme" -t 2000

