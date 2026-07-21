#!/bin/sh

LID_STATE_FILE="/proc/acpi/button/lid/LID0/state"

if [ ! -f "$LID_STATE_FILE" ]; then
    exit 0
fi

if grep -q "closed" "$LID_STATE_FILE"; then
    hyprctl eval "hl.monitor({ output = 'eDP-1', disabled = true })"
else
    hyprctl eval "hl.monitor({ output = 'eDP-1', mode = '1920x1200', position='auto', scale = '1' })"
fi
