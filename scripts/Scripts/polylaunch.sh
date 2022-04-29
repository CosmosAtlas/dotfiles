#!/usr/bin/env bash

killall -9 polybar

echo "---" | tee -a /tmp/polybar.log

setsid polybar example >> /tmp/polybar.log 2>&1 &
