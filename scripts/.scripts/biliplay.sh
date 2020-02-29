#!/usr/bin/env bash

XML_DIR=/tmp/

echo "Downloading danmaku file to temp"
DANMAKU_COMMENT_ID=`danmaku-dl.py $1 $XML_DIR`

echo "Converting danmaku to ass file"
danmaku2ass-c.sh $XML_DIR$DANMAKU_COMMENT_ID.xml $XML_DIR$DANMAKU_COMMENT_ID.ass

echo "Playing video with danmaku"
ykdl -p "mpv --sub-files=$XML_DIR$DANMAKU_COMMENT_ID.ass" $1
