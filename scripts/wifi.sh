#!/usr/bin/env bash
# wifi_notification.sh
# Notifies the user when the WiFi is connected or disconnected.

# Configuration
STATE_FILE="$HOME/tmp/wifi_state.tmp"
ICON_DIR="$HOME/.local/bin/scripts/icons/"
CONNECTED_ICON="${ICON_DIR}wifi.svg"
DISCONNECTED_ICON="${ICON_DIR}wifi_off.svg"

# Function to get WiFi status and name
get_wifi_status() {
    # Check if wireless interface is available
    if [[ -e "/sys/class/net/wlan0/operstate" ]]; then
        # Get the operational status of the wireless interface
        wifi_status=$(cat /sys/class/net/wlan0/operstate)
        if [[ "$wifi_status" == "up" ]]; then
            # Get the connected WiFi name (SSID) using iwgetid
            wifi_name=$(iwgetid -r)
            if [[ -n "$wifi_name" ]]; then
                echo "$wifi_name"
            else
                echo "Disconnected"
            fi
        else
            echo "Disconnected"
        fi
    else
        echo "No Wireless Interface"
    fi
}

# Function to send notification
send_notification() {
    local message=$1
    local icon=$2
    notify-send -u normal "WiFi Status" "$message" -i "$icon" -t 3000 -r 9991
}

# Initial setup: Set last state to empty if state file doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "" > "$STATE_FILE"
fi

while true; do
    WIFI_NAME=$(get_wifi_status)
    LAST_STATE=$(cat "$STATE_FILE")

    if [[ "$WIFI_NAME" != "Disconnected" && "$WIFI_NAME" != "No Wireless Interface" ]]; then
        if [ "$LAST_STATE" != "CONNECTED" ]; then
            send_notification "Connected to: $WIFI_NAME" "$CONNECTED_ICON"
            echo "CONNECTED" > "$STATE_FILE"
        fi
    else
        if [ "$LAST_STATE" != "DISCONNECTED" ]; then
            send_notification "WiFi Disconnected" "$DISCONNECTED_ICON"
            echo "DISCONNECTED" > "$STATE_FILE"
        fi
    fi

    sleep 10  # Check every 5 seconds
done

