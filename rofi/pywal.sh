#!/bin/bash

JSONDIR=~/.config/wal/colorschemes/dark

if [ -z $@ ]
then
    ls $JSONDIR | awk -F . '{print $1}'
else
    wal -f $@ -o ~/.scripts/pywal-apply.sh -g > /dev/null &
fi
