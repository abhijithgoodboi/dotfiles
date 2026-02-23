#!/usr/bin/env bash
# battery_plugged.sh
# Notifies the user when the charger is plugged in or unplugged.

# Configuration
STATE_FILE="$HOME/tmp/battery_plugged_state.tmp"
BATTERY_PATH="/sys/class/power_supply/BAT1"
ICON_DIR="$HOME/.local/bin/scripts/icons/"
PLUGGED_ICON="${ICON_DIR}battery-charging.svg"
UNPLUGGED_ICON="${ICON_DIR}battery-50.svg"

# Function to get battery status
get_battery_status() {
    cat "${BATTERY_PATH}/status"
}

# Function to send notification
send_notification() {
    local message=$1
    local icon=$2
    notify-send -u normal "Charger Status" "$message" -i "$icon" -t 3000 -r 9990
}

# Initial setup: Set last state to empty if state file doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "" > "$STATE_FILE"
fi

while true; do
    BATTERY_STATUS=$(get_battery_status)
    LAST_STATE=$(cat "$STATE_FILE")

    if [[ "$BATTERY_STATUS" == "Charging" ]]; then
        if [ "$LAST_STATE" != "CHARGING" ]; then
            send_notification "Charger plugged in." "$PLUGGED_ICON"
            echo "CHARGING" > "$STATE_FILE"
        fi
    elif [[ "$BATTERY_STATUS" == "Discharging" ]]; then
        if [ "$LAST_STATE" != "DISCHARGING" ]; then
            send_notification "Charger unplugged." "$UNPLUGGED_ICON"
            echo "DISCHARGING" > "$STATE_FILE"
        fi
    fi

    sleep 15  # Check every 10 seconds
done

