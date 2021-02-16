#!/bin/sh

# Display number of unread mail and an loading icon if updateing.
# When clicked, brings up `neomutt`

case $BLOCK_BUTTON in
    1) setsid -f "$TERMINAL" -e "neomutt" ;;
    2) setsid -f pc mailsync > /dev/null ;;
    3) notify-send "Mail module" "\- Shows unread mail
- Shows 🔃 if syncing mail
- Left click opens neomutt
- Middle click syncs mail" ;;
    6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

pidof mbsync >/dev/null 2>&1 && icon="🔃"

echo "$icon U" $(find $HOME/.local/share/mail/uwaterloo/INBOX/new -type f | wc -l) " G" $(find /home/cosmos/.local/share/mail/zhuwenhan950913@gmail.com/INBOX/new -type f | wc -l)
