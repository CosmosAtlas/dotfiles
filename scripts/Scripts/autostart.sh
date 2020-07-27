#!/bin/sh 

echo "Auto start applications"
source /home/cosmos/.screenlayout/standard.sh

# Set correct cursor
xsetroot -cursor_name left_ptr &

# Start up applications
/home/cosmos/Scripts/xcape.sh &


/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

pkill picom
nitrogen --restore; sleep 1; picom -b &

pkill xfce4-power-manager
xfce4-power-manager &

pkill udiskie
udiskie --tray &

pkill dunst
dunst &

pkill pasystray
pasystray &

pm2 kill
pm2 start clash

pkill xidlehook
xidlehook --not-when-audio --not-when-fullscreen --timer 600 "betterlockscreen -l blur" '' &

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh) &

pkill dwmblocks
dwmblocks &

pkill fcitx5
fcitx5 &

pkill aria2c
aria2c -D &

# mpd &
# /home/cosmos/.scripts/pomolaunch.sh &
# syncthing-gtk &
echo "Startup applications launched"
