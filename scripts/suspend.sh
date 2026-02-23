#!/usr/bin/env bash

# Lock after 1 minute of inactivity
LOCK_TIME=60

# Set wallpaper for lockscreen (if not already cached)
WALLPAPER=$(grep feh ~/.fehbg | awk '{print $NF}' | tr -d "'")
betterlockscreen -u "$WALLPAPER" --blur 0.7 &

# Run xidlehook for locking only
xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer $LOCK_TIME \
    'betterlockscreen -l' \
    ''

