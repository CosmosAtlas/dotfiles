#!/usr/bin/env sh
echo "New mail U:" $(find $HOME/.local/share/mail/uwaterloo/INBOX/new -type f | wc -l) " G:" $(find /home/cosmos/.local/share/mail/gmail/INBOX/new -type f | wc -l)
