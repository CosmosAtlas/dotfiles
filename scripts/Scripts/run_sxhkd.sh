#!/bin/sh

# Launch shortcut manager
setxkbmap -layout us -option 'caps:ctrl_modifier'
pkill -x sxhkd
setsid sxhkd -c $HOME/.config/sxhkd/sxhkdrc-dwm &
sleep 0.5
setxkbmap -layout us -variant dvp -option 'caps:ctrl_modifier'
