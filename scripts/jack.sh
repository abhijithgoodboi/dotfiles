#!/usr/bin/env bash
# audiojack_status.sh
# Notifies the user when the headphone jack is plugged in or unplugged.

# Configuration
STATE_FILE="$HOME/tmp/audiojack_status.tmp"
ICON_DIR="$HOME/.local/bin/scripts/icons/"
CONNECTED_ICON="${ICON_DIR}headphone_connected.svg"
DISCONNECTED_ICON="${ICON_DIR}headphone_disconnected.svg"

# Function to get the active port of the default sink
get_active_port() {
    DEFAULT_SINK=$(pactl get-default-sink)
    pactl list sinks | awk -v sink="$DEFAULT_SINK" '
        $1 == "Name:" && $2 == sink {found=1}
        found && /Active Port:/ {print $3; exit}
    '
}

# Function to send notification
send_notification() {
    local message=$1
    local icon=$2
    notify-send -u normal "Audio Jack Status" "$message" -i "$icon" -t 3000 -r 9991
}

# Initial setup: Set last state to empty if state file doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "" > "$STATE_FILE"
fi

while true; do
    ACTIVE_PORT=$(get_active_port)
    LAST_STATE=$(cat "$STATE_FILE")

    # Check if ACTIVE_PORT contains 'headphones' or 'headphone'
    if [[ "$ACTIVE_PORT" == *"headphones"* || "$ACTIVE_PORT" == *"headphone"* ]]; then
        CURRENT_STATE="CONNECTED"
        if [ "$LAST_STATE" != "$CURRENT_STATE" ]; then
            send_notification "Headphone connected." "$CONNECTED_ICON"
            echo "$CURRENT_STATE" > "$STATE_FILE"
        fi
    else
        CURRENT_STATE="DISCONNECTED"
        if [ "$LAST_STATE" != "$CURRENT_STATE" ]; then
            # Optionally, get battery capacity for the notification
            #BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null || echo "Unknown")
            send_notification "Headphone disconnected." "$DISCONNECTED_ICON"
            echo "$CURRENT_STATE" > "$STATE_FILE"
        fi
    fi

    sleep 1  # Adjust sleep time as needed
done

