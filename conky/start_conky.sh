#!/bin/bash
killall conky
sleep 3
LANG=en_US.UTF-8 conky -c ~/.config/conky/conky.conf
