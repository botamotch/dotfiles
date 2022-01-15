#!/bin/bash
killall conky
sleep 10
LANG=C conky -c ~/.config/conky/conky.conf
