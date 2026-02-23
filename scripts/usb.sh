#!/usr/bin/env bash
# usb_status.sh
# Notifies the user when a USB storage device is connected or disconnected.

# Configuration
STATE_FILE="$HOME/tmp/usb_status.tmp"
ICON_DIR="$HOME/.local/bin/scripts/icons/"
CONNECTED_ICON="${ICON_DIR}usb_connected.svg"
DISCONNECTED_ICON="${ICON_DIR}usb_disconnected.png"

# Function to get a list of connected USB storage devices
get_connected_usb_storage() {
    lsblk -o NAME,TYPE,RM,SIZE,MODEL | awk '/disk/ && $3==1 {print $5}'
}

# Function to send notification
send_notification() {
    local message=$1
    local icon=$2
    notify-send -u normal "USB Status" "$message" -i "$icon" -t 3000 -r 9992
}

# Initial setup: Set last state to empty if state file doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "" > "$STATE_FILE"
fi

while true; do
    # Get the current list of connected USB storage devices
    CURRENT_STATE=$(get_connected_usb_storage)

    # Get the last known state from the state file
    LAST_STATE=$(cat "$STATE_FILE")

    # Compare states to detect changes
    if [ "$CURRENT_STATE" != "$LAST_STATE" ]; then
        # Determine if devices were added or removed
        if [[ "$CURRENT_STATE" > "$LAST_STATE" ]]; then
            NEW_DEVICE=$(comm -13 <(echo "$LAST_STATE" | sort) <(echo "$CURRENT_STATE" | sort))
            send_notification "USB connected: $NEW_DEVICE" "$CONNECTED_ICON"
        else
            REMOVED_DEVICE=$(comm -23 <(echo "$LAST_STATE" | sort) <(echo "$CURRENT_STATE" | sort))
            #send_notification "USB disconnected: $REMOVED_DEVICE" "$DISCONNECTED_ICON"
            send_notification "$REMOVED_DEVICE disconnected." "$DISCONNECTED_ICON"
        fi

        # Update the state file
        echo "$CURRENT_STATE" > "$STATE_FILE"
    fi

    sleep 15  # Adjust sleep time as needed
done

