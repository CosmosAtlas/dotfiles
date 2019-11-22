#!/usr/bin/env bash

ASS_FILE=/tmp/temp_ass.ass
XML_FILE=/tmp/temp_xml.xml

danmaku-dl.py $1 $XML_FILE

danmaku2ass-c.sh $XML_FILE $ASS_FILE

mpv $1 --sub-files $ASS_FILE
