#!/bin/sh

pkill -x picom
nitrogen --restore
setsid picom -b &

notify-send "Restarted picom"
