#!/usr/bin/env bash

# Terminate already running bar instances
killall -q xcape

# Wait until the processes have been shut down
while pgrep -u $UID -x xcape >/dev/null; do sleep 1; done

# Launch bar1 and bar2
xcape -e "Control_L=Escape"

xcape -e "Caps_Lock=Escape"

echo "Xcape launched..."
