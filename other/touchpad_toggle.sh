#!/usr/bin/bash

enabled=$(xinput list-props 'VEN_0488:00 0488:102D Touchpad' | grep 'Device Enabled' | awk -F : '{print $2}')

xinput set-prop 'VEN_0488:00 0488:102D Touchpad' 'Device Enabled' $((1 - $enabled))
# xinput set-prop 'VEN_04F3:00 04F3:325F Touchpad' 'Device Enabled' 1
# xinput set-prop 'VEN_04F3:00 04F3:325F Touchpad' 'Device Enabled' 0

if [ "$enabled" -eq 0 ]; then
    state="enable"
else
    state="disable"
fi

notify-send --hint=int:transient:1 'Touchpad Toggle' "to $state" --icon=dialog-information
