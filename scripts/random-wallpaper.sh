#!/usr/bin/env bash

while true; do
    feh --bg-fill --randomize ~/wallpapers/
    sleep 15
done












# #!/bin/bash
#
# # Kill the script if it's already running
# for pid in $(pidof -x ran-wal.sh); do
#     if [ "$pid" != "$$" ]; then
#         kill -9 "$pid"
#         exit 1
#     fi
# done
#
# # Wallpaper directory
# WALLPAPER_DIR="$HOME/wallpapers"
#
# # Check if directory exists
# if [ ! -d "$WALLPAPER_DIR" ]; then
#     echo "Directory not found: $WALLPAPER_DIR"
#     exit 1
# fi
#
# # Infinite loop for random wallpapers
# while true; do
#     WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( \
#         -iname "*.jpg" -o \
#         -iname "*.jpeg" -o \
#         -iname "*.png" -o \
#         -iname "*.webp" -o \
#         -iname "*.bmp" -o \
#         -iname "*.gif" \
#     \) | shuf -n 1)
#
#     [ -n "$WALLPAPER" ] && feh --bg-fill "$WALLPAPER"
#     sleep 15
# done



