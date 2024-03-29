#!/bin/sh
# TODO notification
val=$(xinput list-props 'VEN_0488:00 0488:102D Touchpad' | grep 'Device Enabled' | awk -F : '{print $2}')

xinput set-prop 'VEN_0488:00 0488:102D Touchpad' 'Device Enabled' $((1 - $val))
# xinput set-prop 'VEN_04F3:00 04F3:325F Touchpad' 'Device Enabled' 1
# xinput set-prop 'VEN_04F3:00 04F3:325F Touchpad' 'Device Enabled' 0

state="enable"
# if $val -eq "1"; then
#     state="enable"
# else
#     state="disable"
# fi

notify-send 'Touchpad Toggle' "state to $state" --icon=dialog-information
