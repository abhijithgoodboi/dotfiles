#!/usr/bin/env bash
# battery_alert.sh
# Sends notifications for low battery, critical battery, and full charge.

# Configuration
BATTERY_PATH="/sys/class/power_supply/BAT1"
LOW_BATTERY=20
CRITICAL_BATTERY=10

# Icons (ensure these paths are correct)
ICON_DIR="$HOME/.local/bin/scripts/icons/"
LOW_BATTERY_ICON="${ICON_DIR}battery-low.svg"
CRITICAL_BATTERY_ICON="${ICON_DIR}battery-alert.svg"
FULL_BATTERY_ICON="${ICON_DIR}battery.svg"

# Function to get battery capacity
get_battery_capacity() {
    cat "${BATTERY_PATH}/capacity"
}

# Function to get battery status
get_battery_status() {
    cat "${BATTERY_PATH}/status"
}

# Function to send notification
send_notification() {
    local urgency=$1
    local message=$2
    local icon=$3
    notify-send -u "$urgency" "Battery Alert" "$message" -i "$icon" -r 9991
}

# Initial state to track notifications
NOTIFIED_LOW=false
NOTIFIED_CRITICAL=false
NOTIFIED_FULL=false

while true; do
    BATTERY_CAPACITY=$(get_battery_capacity)
    BATTERY_STATUS=$(get_battery_status)

    if [[ "$BATTERY_STATUS" == "Discharging" ]]; then
        if [[ "$BATTERY_CAPACITY" -le "$CRITICAL_BATTERY" && "$NOTIFIED_CRITICAL" == "false" ]]; then
            send_notification "critical" "Battery critically low (${BATTERY_CAPACITY}%). Plug in your charger!" "$CRITICAL_BATTERY_ICON" -t 0
            NOTIFIED_CRITICAL=true
            NOTIFIED_LOW=true # Ensure no duplicate low alerts
        elif [[ "$BATTERY_CAPACITY" -le "$LOW_BATTERY" && "$BATTERY_CAPACITY" -gt "$CRITICAL_BATTERY" && "$NOTIFIED_LOW" == "false" ]]; then
            send_notification "normal" "Battery low (${BATTERY_CAPACITY}%). Please plug in your charger." "$LOW_BATTERY_ICON"
            NOTIFIED_LOW=true
        fi
    elif [[ "$BATTERY_STATUS" == "Full" && "$NOTIFIED_FULL" == "false" ]]; then
        send_notification "normal" "Battery fully charged. You can unplug your charger." "$FULL_BATTERY_ICON"
        NOTIFIED_FULL=true
    fi

    # Reset notifications when conditions no longer apply
    if [[ "$BATTERY_STATUS" == "Charging" ]]; then
        NOTIFIED_LOW=false
        NOTIFIED_CRITICAL=false
        NOTIFIED_FULL=false
    fi

    sleep 15 # Check every 60 seconds
done

