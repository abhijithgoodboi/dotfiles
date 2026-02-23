
#!/usr/bin/env bash

# Icons
iDIR="$HOME/.local/bin/scripts/icons"
notify_cmd='notify-send -u normal -r 555 '

# Default sink (output)
SINK="@DEFAULT_AUDIO_SINK@"
# Default source (mic)
SOURCE="@DEFAULT_AUDIO_SOURCE@"

# Get Volume
get_volume() {
    wpctl get-volume $SINK | awk '{print int($2 * 100)}'
}

# Get icons
get_icon() {
    current="$(get_volume)"
    if [[ "$current" -eq 0 ]]; then
        icon="$iDIR/volume-mute.svg"
    elif [[ "$current" -le 30 ]]; then
        icon="$iDIR/volume-low.svg"
    elif [[ "$current" -le 60 ]]; then
        icon="$iDIR/volume-medium.svg"
    else
        icon="$iDIR/volume-high.svg"
    fi
}

# Notify
notify_user() {
    ${notify_cmd} -i "$icon" "Volume : $(get_volume)%"
}

# Increase Volume
inc_volume() {
    wpctl set-mute $SINK 0
    wpctl set-volume -l 1.0 $SINK 5%+ && get_icon && notify_user
}

# Increase Volume by 1
inc_volume_fine() {
    wpctl set-mute $SINK 0
    wpctl set-volume -l 1.0 $SINK 1%+ && get_icon && notify_user
}

# Decrease Volume
dec_volume() {
    wpctl set-mute $SINK 0
    wpctl set-volume $SINK 5%- && get_icon && notify_user
}

# Decrease Volume by 1
dec_volume_fine() {
    wpctl set-mute $SINK 0
    wpctl set-volume $SINK 1%- && get_icon && notify_user
}

# Toggle Mute
toggle_mute() {
    if wpctl get-volume $SINK | grep -q MUTED; then
        wpctl set-mute $SINK 0 && get_icon && ${notify_cmd} -i "$icon" "Unmute"
    else
        wpctl set-mute $SINK 1 && ${notify_cmd} -i "$iDIR/volume-mute.svg" "Mute"
    fi
}

# Toggle Mic
toggle_mic() {
    if wpctl get-volume $SOURCE | grep -q MUTED; then
        wpctl set-mute $SOURCE 0 && ${notify_cmd} -i "$iDIR/microphone.svg" "Microphone Switched ON"
    else
        wpctl set-mute $SOURCE 1 && ${notify_cmd} -i "$iDIR/microphone-off.svg" "Microphone Switched OFF"
    fi
}

# Execute accordingly
if [[ -x "$(command -v wpctl)" ]]; then
    case "$1" in
        --get) get_volume ;;
        --inc) inc_volume ;;
        --inc-fine) inc_volume_fine ;;
        --dec) dec_volume ;;
        --dec-fine) dec_volume_fine ;;
        --toggle) toggle_mute ;;
        --toggle-mic) toggle_mic ;;
        *) echo "$(get_icon)" "$(get_volume)%" ;;
    esac
else
    ${notify_cmd} "'wpctl' is not installed."
fi

