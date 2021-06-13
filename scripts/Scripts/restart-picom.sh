#!/bin/sh

pkill -x picom
nitrogen --restore
sleep 1
picom -b

notify-send "Restarted picom"
