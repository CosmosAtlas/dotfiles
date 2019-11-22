killall mbsync &>/dev/null
mbsync -a -q
echo `date` > /home/cosmos/.scripts/mbsync.log
