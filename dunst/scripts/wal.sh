#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/wallpapers"

# Check if feh is installed
if ! command -v feh &>/dev/null; then
    notify-send "Error" "feh is not installed."
    exit 1
fi

# Check if dunst is installed
if ! command -v notify-send &>/dev/null; then
    echo "notify-send (dunst) is not installed."
    exit 1
fi

# Select a random wallpaper from the directory
SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# If no wallpaper is found, exit
if [ -z "$SELECTED_WALLPAPER" ]; then
    notify-send "Wallpaper Selector" "No wallpapers found in the directory."
    exit 0
fi

# Set the selected wallpaper
feh --bg-scale "$SELECTED_WALLPAPER"

# Send notification with dunst
notify-send -i "$SELECTED_WALLPAPER" "Wallpaper Changed" "$(basename "$SELECTED_WALLPAPER")."

exit 0

