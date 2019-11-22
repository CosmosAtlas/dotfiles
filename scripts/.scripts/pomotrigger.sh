#!/usr/bin/env bash

case $(pomodoroc.py inquiry) in
    0)
        pomodoroc.py start
        ;;
    1)
        pomodoroc.py pause
        ;;
    2)
        pomodoroc.py start
        ;;
    3)
        pomodoroc.py resume
        ;;

    *)
        echo "Invalid status received from pomodorod"
        exit 1
esac
