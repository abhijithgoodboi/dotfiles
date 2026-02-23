#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/wallpapers"

while true; do
    # Step 1: Mark wallpapers in thumbnail mode
    SELECTED=$(nsxiv -t -o "$WALLPAPER_DIR")

    if [ -z "$SELECTED" ]; then
        notify-send -i dialog-warning "No wallpaper selected."
        exit 1
    fi

    SELECTED_COUNT=$(echo "$SELECTED" | wc -l)

    while true; do
        # Step 2: Choose one from marked
        CHOICE=$(echo "$SELECTED" | dmenu -i -l 10 -p "Choose wallpaper:")

        if [ -z "$CHOICE" ]; then
            notify-send -i dialog-warning "No wallpaper chosen"
            exit 1
        fi

        # Step 3: Preview image in float sxiv
        setsid sxiv "$CHOICE" &

        # Step 4: Ask for confirmation
        if [ "$SELECTED_COUNT" -gt 1 ]; then
            CONFIRM=$(printf "Yes\nNo (Go Back)" | dmenu -i -p "Set this wallpaper?")
        else
            CONFIRM=$(printf "Yes\nNo (Reselect)" | dmenu -i -p "Set this wallpaper?")
        fi

        # Step 5: Kill preview
        pkill -f "sxiv $CHOICE"

        case "$CONFIRM" in
            Yes)
                # Step 6: Select feh mode
                FEH_MODE=$(printf "scale\nfill\ncenter\ntile" | dmenu -i -p "Choose feh mode:")
                case "$FEH_MODE" in
                    scale)  FLAG="--bg-scale" ;;
                    fill)   FLAG="--bg-fill" ;;
                    center) FLAG="--bg-center" ;;
                    tile)   FLAG="--bg-tile" ;;
                    *)      notify-send -i dialog-error "Invalid mode selected"; exit 1 ;;
                esac

                feh "$FLAG" "$CHOICE"
                notify-send -i "$CHOICE" "Wallpaper Set" "$(basename "$CHOICE") ($FEH_MODE)"
                exit 0
                ;;
            "No (Go Back)")
                continue  # Go back to dmenu selection
                ;;
            "No (Reselect)")
                break  # Break inner loop → rerun nsxiv
                ;;
            *)
                notify-send -i dialog-warning "Wallpaper change cancelled"
                exit 0
                ;;
        esac
    done
done





# #!/bin/bash
#
# WALLPAPER_DIR="$HOME/wallpapers"
#
# SELECTED=$(nsxiv -t -o "$WALLPAPER_DIR")
#
# if [ -n "$SELECTED" ]; then
#     CHOICE=$(echo "$SELECTED" | dmenu -i -l 10 -p "Choose wallpaper:")
#
#     if [ -n "$CHOICE" ]; then
#         FEH_MODE=$(printf "scale\nfill\ncenter\ntile" | dmenu -i -p "Choose feh mode:")
#
#         case "$FEH_MODE" in
#             scale)  FLAG="--bg-scale" ;;
#             fill)   FLAG="--bg-fill" ;;
#             center) FLAG="--bg-center" ;;
#             tile)   FLAG="--bg-tile" ;;
#             *)      notify-send "Invalid mode selected"; exit 1 ;;
#         esac
#
#         feh "$FLAG" "$CHOICE"
#         notify-send -i "$CHOICE" "Wallpaper Set" "$(basename "$CHOICE") ($FEH_MODE)"
#     else
#         notify-send -i dialog-warning "No wallpaper chosen"
#     fi
# else
#     notify-send -i dialog-warning "No wallpaper selected in nsxiv"
# fi


# #!/bin/bash
#
# WALLPAPER_DIR="$HOME/wallpapers"
#
# # Open nsxiv in thumbnail mode and get marked files
# SELECTED=$(nsxiv -t -o "$WALLPAPER_DIR")
#
# # If any images were marked
# if [ -n "$SELECTED" ]; then
#     # Let user pick one from the marked list
#     CHOICE=$(echo "$SELECTED" | dmenu -i -l 10 -p "Choose wallpaper:")
#
#     if [ -n "$CHOICE" ]; then
#         # Ask for confirmation
#         CONFIRM=$(printf "Yes\nNo" | dmenu -i -p "Use this wallpaper?")
#
#         if [ "$CONFIRM" = "Yes" ]; then
#             # Ask for feh mode
#             FEH_MODE=$(printf "scale\nfill\ncenter\ntile" | dmenu -i -p "Choose feh mode:")
#
#             case "$FEH_MODE" in
#                 scale)  FLAG="--bg-scale" ;;
#                 fill)   FLAG="--bg-fill" ;;
#                 center) FLAG="--bg-center" ;;
#                 tile)   FLAG="--bg-tile" ;;
#                 *)      notify-send -i dialog-error "Invalid mode selected"; exit 1 ;;
#             esac
#
#             # Set wallpaper with feh
#             feh "$FLAG" "$CHOICE"
#             notify-send -i "$CHOICE" "Wallpaper Set" "$(basename "$CHOICE") ($FEH_MODE)"
#         else
#             notify-send -i dialog-warning "Wallpaper change cancelled"
#             exec "$0" # Restart script for a new selection
#         fi
#     else
#         notify-send -i dialog-warning "No wallpaper chosen"
#     fi
# else
#     notify-send -i dialog-warning "No wallpaper selected in nsxiv"
# fi





