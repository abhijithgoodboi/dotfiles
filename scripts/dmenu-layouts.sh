#!/usr/bin/env bash

# Layout definitions
layouts=(
    "[]=  tile"
    "M[]  monocle"
    "@[]  spiral"
    "/[]  dwindle"
    "H[]  deck"
    "TTT  bstack"
    "===  bstackhoriz"
    "HHH  grid"
    "###  nrowgrid"
    "---  horizgrid"
    ":::  gaplessgrid"
    "|M|  centeredmaster"
    ">M>  centeredfloatMaster"
    "|+|  tatami"
    "><>  floating"
)

# Convert array to newline-separated list for dmenu
layout_menu=$(printf "%s\n" "${layouts[@]}")

# Launch dmenu prompt
chosen=$(echo "$layout_menu" | dmenu -i -p "Switch Layout:")

# Get index of selected layout
for i in "${!layouts[@]}"; do
    if [[ "${layouts[$i]}" == "$chosen" ]]; then
        dwmc setlayoutex "$i"
        exit 0
    fi
done

# Fallback
notify-send "No layout selected" || echo "No layout selected"

