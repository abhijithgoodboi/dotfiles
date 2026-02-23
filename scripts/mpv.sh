#
# #!/bin/bash
#
# # mpv + dmenu file browser with multi-select (files + folders)
# # Save as mpv-dmenu.sh and chmod +x mpv-dmenu.sh
#
# BROWSE_DIR="$HOME"   # Start from home directory
# SELECTIONS=()        # Store selected files/folders
#
# while true; do
#     # Add "Play Now" and ".. (Up)" options
#     CHOICE=$( (echo "[ Play Now]"; echo ".."; ls -1p "$BROWSE_DIR" 2>/dev/null) \
#         | dmenu -i -l 20 -p "Inside: $BROWSE_DIR (selected: ${#SELECTIONS[@]})")
#
#     # If nothing selected → exit
#     [ -z "$CHOICE" ] && exit 0
#
#     if [ "$CHOICE" = "[ Play Now]" ]; then
#         if [ ${#SELECTIONS[@]} -eq 0 ]; then
#             notify-send "mpv-dmenu" "No files selected!"
#             continue
#         fi
#
#         # Expand folders into file lists
#         FILES=()
#         for ITEM in "${SELECTIONS[@]}"; do
#             if [ -d "$ITEM" ]; then
#                 FILES+=($(find "$ITEM" -type f \
#                     \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" -o -iname "*.mov" -o -iname "*.webm" \) | sort))
#             else
#                 FILES+=("$ITEM")
#             fi
#         done
#
#         # Play all with mpv
#         mpv "${FILES[@]}"
#         exit 0
#     elif [ "$CHOICE" = ".." ]; then
#         # Go one directory up
#         BROWSE_DIR=$(dirname "$BROWSE_DIR")
#     else
#         FULL_PATH="$BROWSE_DIR/$CHOICE"
#
#         if [ -d "$FULL_PATH" ]; then
#             # Ask: Add or Enter folder
#             ACTION=$(printf "Enter\nAdd Folder" | dmenu -i -p "Folder: $CHOICE")
#             if [ "$ACTION" = "Add Folder" ]; then
#                 SELECTIONS+=("$FULL_PATH")
#                 notify-send "mpv-dmenu" "Added folder: $CHOICE"
#             elif [ "$ACTION" = "Enter" ]; then
#                 BROWSE_DIR="$FULL_PATH"
#             fi
#         else
#             # Add file to selection
#             SELECTIONS+=("$FULL_PATH")
#             notify-send "mpv-dmenu" "Added file: $CHOICE"
#         fi
#     fi
# done


# #!/bin/bash
#
# # mpv + dmenu with "Add or Play" prompt
# # Save as mpv-dmenu.sh and chmod +x mpv-dmenu.sh
#
# BROWSE_DIR="$HOME"   # Start browsing from home
# FILES=()             # Store selected files
#
# while true; do
#     # Show options
#     CHOICE=$( (echo "[ Play Now ]"; echo ".."; ls -1p "$BROWSE_DIR" 2>/dev/null) \
#         | dmenu -i -l 20 -p "Inside: $BROWSE_DIR (selected: ${#FILES[@]})")
#
#     # Exit if cancelled
#     [ -z "$CHOICE" ] && exit 0
#
#     if [ "$CHOICE" = "[ Play Now ]" ]; then
#         if [ ${#FILES[@]} -eq 0 ]; then
#             notify-send "mpv-dmenu" "No files selected!"
#             continue
#         fi
#         mpv "${FILES[@]}"
#         exit 0
#
#     elif [ "$CHOICE" = ".." ]; then
#         # Go up a directory
#         BROWSE_DIR=$(dirname "$BROWSE_DIR")
#
#     else
#         FULL_PATH="$BROWSE_DIR/$CHOICE"
#
#         if [ -d "$FULL_PATH" ]; then
#             # Enter folder
#             BROWSE_DIR="$FULL_PATH"
#         else
#             # Ask user: Add to list or Play instantly
#             ACTION=$(printf "Add\nPlay" | dmenu -i -p "File: $CHOICE")
#             if [ "$ACTION" = "Add" ]; then
#                 FILES+=("$FULL_PATH")
#                 notify-send "mpv-dmenu" "Added: $CHOICE"
#             elif [ "$ACTION" = "Play" ]; then
#                 mpv "$FULL_PATH"
#                 exit 0
#             fi
#         fi
#     fi
# done



#!/bin/bash

# mpv + dmenu multi-file picker
# Save as mpv-dmenu.sh and chmod +x mpv-dmenu.sh

BROWSE_DIR="$HOME"   # Start browsing from home
FILES=()             # Store selected files

while true; do
    # Show Play, Up, and list contents
    CHOICE=$( (echo "[ Play Now ]"; echo ".."; ls -1p "$BROWSE_DIR" 2>/dev/null) \
        | dmenu -i -l 20 -p "Inside: $BROWSE_DIR (selected: ${#FILES[@]})")

    # Exit if cancelled
    [ -z "$CHOICE" ] && exit 0

    if [ "$CHOICE" = "[ Play Now ]" ]; then
        if [ ${#FILES[@]} -eq 0 ]; then
            notify-send "mpv-dmenu" "No files selected!"
            continue
        fi

        mpv "${FILES[@]}"
        exit 0

    elif [ "$CHOICE" = ".." ]; then
        # Go one directory up
        BROWSE_DIR=$(dirname "$BROWSE_DIR")

    else
        FULL_PATH="$BROWSE_DIR/$CHOICE"

        if [ -d "$FULL_PATH" ]; then
            # Enter folder
            BROWSE_DIR="$FULL_PATH"
        else
            # Add file to list
            FILES+=("$FULL_PATH")
            notify-send "mpv-dmenu" "Added file: $CHOICE"
        fi
    fi
done

