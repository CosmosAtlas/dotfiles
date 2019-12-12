#!/usr/bin/env bash

danmaku2ass -s 1280x720 -fn 'Noto Sans CJK SC' -fs 36 -a 0.8 -dm 10 -ds 10 "$1" > "$2"
