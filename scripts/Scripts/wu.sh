#!/usr/bin/env zsh


wu () {
    cd /home/cosmos/Sync/WeeklyUpdates/
    ./gen.py
    cd `date | cut -d ' ' -f 4`
    cd $(ls | fzf --query $(date | cut -d ' ' -f 4)W$(date +%V)- --select-1)
    echo "Directory switched to:" $(pwd)
}
