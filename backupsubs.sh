#!/bin/bash

#FILE="$1"


SECS=$(date +%s)
DAYS=$(expr $SECS / 86400)
echo $DAYS

cbmctrl reset
bash resetusb.sh
sleep 1
cbmcopy -t original -d 1541 -r 8 "(no.)" -o "no-$DAYS.seq"
sleep 1
cbmcopy -t original -d 1541 -r 8 "(count)" -o "count-$DAYS.seq"
sleep 1
cbmcopy -t original -d 1541 -r 8 "(bbs-log)" -o "bbs-log-$DAYS.seq"
sleep 1

mv "no-$DAYS.seq" "count-$DAYS.seq" "bbs-log-$DAYS.seq" backups/

bash deletefile.sh "(bbs-log)"
bash writefile.sh "(bbs-log)"

python3 report.py $DAYS

bash deletefile.sh "(bbs-v)"
bash writefile.sh "(bbs-v)"

bash resetusb.sh
cbmctrl reset

