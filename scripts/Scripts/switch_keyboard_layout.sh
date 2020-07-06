#!/bin/bash

CURRENT_LAYOUT=$(setxkbmap -query | awk -F : 'NR==4{print $2}' | sed 's/ //g')

if [ "$CURRENT_LAYOUT" == "dvp" ]; then
    setxkbmap -layout us
else
    setxkbmap -layout us -variant dvp -option 'caps:ctrl_modifier'
fi
