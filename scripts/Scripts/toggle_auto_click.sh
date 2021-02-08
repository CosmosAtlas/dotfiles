#!/bin/sh

case "$(pidof -x perl_auto_click.pl | wc -w)" in

0) echo "script not running, restarting script"
notify-send -t 1000 "Autoclick started"
sleep 0.2
perl_auto_click.pl
;;
1) echo "script already running, stopping script"
    kill -s TERM $(pidof -x perl_auto_click.pl)
    notify-send -t 1000 "Autoclick stoped"
;;
esac
