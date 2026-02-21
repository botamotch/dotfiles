#!/bin/sh

LID_STATE_FILE="/proc/acpi/button/lid/LID0/state"

if [ ! -f "$LID_STATE_FILE" ]; then
    exit 0
fi

if grep -q "closed" "$LID_STATE_FILE"; then
    hyprctl keyword monitor "eDP-1, disable"
else
    hyprctl keyword monitor "eDP-1, 1920x1200,0x0,1"
fi
