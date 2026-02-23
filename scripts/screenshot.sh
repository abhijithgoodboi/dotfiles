#!/usr/bin/env bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>
##
## Script to take screenshots on Archcraft.

# file
time=$(date +%Y-%m-%d-%H-%M-%S)
geometry=$(xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time}_${geometry}.png"
shot=$( ls -t "$dir"*.png 2>/dev/null | head -n1 )

# directory
if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

# notify and view screenshot
notify_view () {
    # notify_cmd_shot='dunstify -u low -h string:x-dunst-stack-tag:obscreenshot -i "$screenshot_path"'
    # ${notify_cmd_shot} "Copied to clipboard."
    # paplay /usr/share/sounds/freedesktop/stereo/screen-capture.oga &>/dev/null &
    # viewnior "${dir}/${file}"
    # if [[ -e "${dir}/${file}" ]]; then
    #     ${notify_cmd_shot} "Screenshot Saved."
    # else
    #     ${notify_cmd_shot} "Screenshot Deleted."
    # fi
    screenshot_path="${dir}/${file}"

    # Notify using the screenshot as icon
    dunstify -u low \
             -h string:x-dunst-stack-tag:obscreenshot \
             -i "$screenshot_path" \
             "Copied to clipboard."

    # Play sound
    paplay /usr/share/sounds/freedesktop/stereo/screen-capture.oga &>/dev/null &

    # View the screenshot
    viewnior "$screenshot_path"

    # Additional notification for status
    if [[ -e "$screenshot_path" ]]; then
        dunstify -u low \
                 -h string:x-dunst-stack-tag:obscreenshot \
                 -i "$screenshot_path" \
                 "Screenshot Saved."
    else
        dunstify -u low \
                 -h string:x-dunst-stack-tag:obscreenshot \
                 "Screenshot Deleted."
    fi
}

# copy screenshot to clipboard
copy_shot () {
    xclip -selection clipboard -t image/png -i "$file"
}

# countdown
countdown () {
    for (( sec = $1; sec > 0; sec-- )); do
        dunstify -t 1000 -h string:x-dunst-stack-tag:screenshottimer -i /home/anastasia/.config/dunst/icons/timer-outline.svg "Taking shot in : $sec"
        sleep 1
    done
}

# take shots
shotnow () {
    scrot "$dir/$file" && notify_view
}

shot5 () {
    countdown 5
    sleep 1 && scrot "$dir/$file" && notify_view
}

shot10 () {
    countdown 10
    sleep 1 && scrot "$dir/$file" && notify_view
}

shotwin () {
    sleep 1 && scrot -u "$dir/$file" && notify_view
}

shotarea () {
    sleep 1 && scrot -s "$dir/$file" && notify_view
}

# execute
case "$1" in
    --now)   shotnow ;;
    --in5)   shot5 ;;
    --in10)  shot10 ;;
    --win)   shotwin ;;
    --area)  shotarea ;;
    *)       echo "Available Options: --now --in5 --in10 --win --area" ;;
esac

exit 0

