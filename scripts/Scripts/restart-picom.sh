#!/bin/sh

pkill -x picom
nitrogen --restore
sleep 1
picom --experimental-backends -b

notify-send "Restarted picom"
