#!/bin/sh
CURRENT=$(hyprctl getoption input:kb_layout | grep 'str:' | awk '{print $2}')
if [ "$CURRENT" = "us" ]; then
    hyprctl keyword input:kb_layout jp
    notify-send "Keyboard" "Layout: JP"
else
    hyprctl keyword input:kb_layout us
    notify-send "Keyboard" "Layout: US"
fi
