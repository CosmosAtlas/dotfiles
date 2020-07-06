#!/usr/bin/env bash

for a in [0-9]*.*; do
    mv $a `printf %04d.%s ${a%.*} ${a##*.}`
done
