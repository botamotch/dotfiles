#!/bin/sh
# TODO notification
val=$(xinput list-props 'VEN_04F3:00 04F3:325F Touchpad' | grep 'Device Enabled' | awk -F : '{print $2}')

xinput set-prop 'VEN_04F3:00 04F3:325F Touchpad' 'Device Enabled' $((1 - $val))
# xinput set-prop 'VEN_04F3:00 04F3:325F Touchpad' 'Device Enabled' 1
# xinput set-prop 'VEN_04F3:00 04F3:325F Touchpad' 'Device Enabled' 0
