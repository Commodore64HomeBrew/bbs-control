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
cbmcopy -t original -d 1541 -r 8 "(bbs-cnt)" -o "count-$DAYS.seq"
sleep 1
cbmcopy -t original -d 1541 -r 8 "(sys-log)" -o "bbs-log-$DAYS.seq"
sleep 1
cbmcopy -t original -d 1541 -r 8 "(graffiti)" -o "graffiti.seq"
sleep 1


mv "no-$DAYS.seq" "count-$DAYS.seq" "bbs-log-$DAYS.seq" backups/
mv "graffiti.seq" graffiti/

bash deletefile.sh "(sys-log)"
bash writefile.sh "(sys-log)"

python3.6 report.py $DAYS

bash graffiti/wallsplit.sh

#cat graffiti/lastfive.seq >> "(val-user)"

mv graffiti/lastfive.seq "(bulletins)"

bash deletefile.sh "(val-user)"
bash writefile.sh "(val-user)"

bash deletefile.sh "(bulletins)"
bash writefile.sh "(bulletins)"

bash resetusb.sh
cbmctrl reset

