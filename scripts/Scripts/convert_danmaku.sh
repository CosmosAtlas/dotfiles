#!/usr/bin/env bash

FILES=$1/*.cmt.xml

for f in $FILES
do
    [[ $f =~ (.*).cmt.xml ]] && danmaku2ass-c.sh "${BASH_REMATCH[1]}.cmt.xml" "${BASH_REMATCH[1]}.ass"
done
