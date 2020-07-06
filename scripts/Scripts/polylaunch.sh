#!/usr/bin/env bash

killall -9 polybar

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

MONITOR=HDMI-A-0 polybar -c ~/.config/polybar/config.ini vert >> /tmp/polybar1.log 2>&1 &
MONITOR=HDMI-A-1 polybar -c ~/.config/polybar/config.ini main >> /tmp/polybar2.log 2>&1 &
