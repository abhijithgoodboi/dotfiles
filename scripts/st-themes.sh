#!/usr/bin/env bash

# Path to your Xresources themes
THEME_DIR="$HOME/suckless/st/xresources"

# Ask the user to pick a theme using dmenu
theme=$(ls "$THEME_DIR" | dmenu -i -p "Choose ST theme:")

# Exit if no theme selected
[ -z "$theme" ] && exit 1

# Load the selected theme and signal st to reload
xrdb -merge "$THEME_DIR/$theme" && kill -USR1 $(pidof st)

