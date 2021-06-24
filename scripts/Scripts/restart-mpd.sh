#!/bin/sh

pkill -x mpd
setsid mpd &
