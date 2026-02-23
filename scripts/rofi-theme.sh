#!/usr/bin/env bash

# Path to the file that imports the selected theme
IMPORT_FILE="$HOME/.config/rofi/powermenu/type-0/shared/colors.rasi"
THEME_DIR="$HOME/.config/rofi/colors"

# Let user select a theme (either passed or prompted via dmenu)
theme="$1"

if [[ -z "$theme" || ! -f "$THEME_DIR/$theme.rasi" ]]; then
    theme=$(ls "$THEME_DIR" | sed 's/\.rasi$//' | dmenu -p "Select Rofi Theme:")
fi

# Exit if no theme selected
if [[ -z "$theme" ]]; then
    notify-send -t 3000 "Rofi Theme" "No theme selected."
    exit 1
fi

# Validate theme file exists
if [[ ! -f "$THEME_DIR/$theme.rasi" ]]; then
    notify-send -t 3000 "Rofi Theme" "Theme not found: $theme"
    exit 1
fi

# Update the @import line
echo "@import \"~/.config/rofi/colors/$theme.rasi\"" > "$IMPORT_FILE"

# Optional: test it by launching rofi
# rofi -show drun -theme "$IMPORT_FILE"

# Notify user
notify-send -t 3000 "Rofi Theme" "Loaded theme: $theme"

