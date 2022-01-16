#!/bin/bash
killall conky
sleep 10
LANG=en_US.UTF-8 conky -c ~/.config/conky/conky.conf
