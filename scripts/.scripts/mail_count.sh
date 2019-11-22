#!/usr/bin/env sh
echo "New mail U:" $(find $HOME/.mail/uwaterloo/INBOX/new -type f | wc -l) " G:" $(find /home/cosmos/.mail/gmail/Inbox/new -type f | wc -l)
