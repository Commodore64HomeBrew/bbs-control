#!/bin/bash

#FILE="$1"


SECS=$(date +%s)
DAYS=$(expr $SECS / 86400)
echo $DAYS


bash resetusb.sh
#cbmctrl reset
sleep 1
cbmcopy -d 1581 -t serial1 -r 8 "(userlog)" -o "userlog-$DAYS.seq"
sleep 1
#cbmctrl reset
bash resetusb.sh
