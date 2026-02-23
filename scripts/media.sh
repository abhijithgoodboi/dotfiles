#!/usr/bin/env bash

# Media Control Script

# Function to play or pause media
toggle_play_pause() {
    playerctl play-pause
}

# Function to play the next track
next_track() {
    playerctl next
}

# Function to play the previous track
previous_track() {
    playerctl previous
}

# Main Execution
case "$1" in
    play-pause)
        toggle_play_pause
        ;;
    next)
        next_track
        ;;
    previous)
        previous_track
        ;;
    *)
        echo "Usage: $0 {play-pause|next|previous}"
        exit 1
        ;;
esac

