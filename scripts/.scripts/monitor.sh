#!/usr/bin/env bash

# ssh narf.cs.queensu.ca "ps aux | grep rsync" | wc -l
# cat code_complete.txt | msmtp -a default zhuwenhan950913@gmail.com


while true; do
    WCL=$(ssh narf.cs.queensu.ca "ps aux | grep rsync" | wc -l)
    echo $WCL
    sleep 5
done

