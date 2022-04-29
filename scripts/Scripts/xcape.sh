#!/usr/bin/env bash

# Terminate already running bar instances
pkill -x xcape

# Wait until the processes have been shut down
while pgrep -u $UID -x xcape >/dev/null; do sleep 1; done

# Launch bar1 and bar2
setsid xcape -e "Control_L=Escape"

setsid xcape -e "Caps_Lock=Escape"

echo "Xcape launched..."
