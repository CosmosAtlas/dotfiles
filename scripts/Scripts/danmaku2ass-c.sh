#!/usr/bin/env bash

danmaku2ass -s 1920x1080 -fn 'Sarasa UI SC' -fs 36 -a 0.8 -dm 10 -ds 10 "$1" > "$2"
