#!/usr/bin/env bash

sleep 1

sessions=$(tmux ls | grep '^[0-9]\+:' | cut -f1 -d':' | sort)

new=0
for old in $sessions
do
    tmux rename -t $old $new
    ((new++))
done
