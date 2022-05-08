#!/bin/sh 

# Set the current working directory as home
cd $HOME

echo "Auto start applications"

# Set screenlayout
source /home/cosmos/.screenlayout/current.sh

# Launch shortcut manager
source /home/cosmos/Scripts/run_sxhkd.sh

# Set correct cursor
xsetroot -cursor_name left_ptr &

# Start up applications
/home/cosmos/Scripts/xcape.sh &

# Network manager
pkill -x nm-applet
setsid nm-applet &

# Launch polkit
setsid /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

/home/cosmos/Scripts/restart-picom.sh &

pkill -x udiskie
udiskie --tray &

pkill -x dunst
dunst &

pkill -x pasystray
pasystray &

# pm2 kill
# pm2 start clash

pkill -x xidlehook
xidlehook --not-when-audio --not-when-fullscreen --timer 600 "betterlockscreen -l blur" '' &

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh) &

pkill -x dwmblocks
dwmblocks &

pkill -x fcitx5
fcitx5 &

# pkill -x aria2c
# aria2c -D &

pkill -x transmission-gtk
transmission-gtk &

$HOME/Scripts/restart-mpd.sh


# /home/cosmos/.scripts/pomolaunch.sh &
# syncthing-gtk &
echo "Startup applications launched"
