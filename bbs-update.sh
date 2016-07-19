#!/bin/bash
FILEOUT="update.log"
ESTAB="ESTAB"

FILENUM=$(shuf -i 1-6 -n 1)

cd /home/pi/Git/bbs-control

cat seqs/connect-msg.seq > seqs/bbs-update.seq
cat seqs/$FILENUM-logo.seq >> seqs/bbs-update.seq
cat seqs/update-msg.seq >> seqs/bbs-update.seq

STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')

while [ "$STATUS" = "$ESTAB" ] ; do
	echo "waiting for session to finish..."
	sleep 30
	STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')
done



bash killsession.sh
bash killsession.sh

tcpser -v 25232 -s 1200 -tsS -l 7 -i "s0=1&s2=43&e0q0v0&c0x1&k0&w" -a seqs/bbs-update.seq -T seqs/bbs-timeout.seq -B seqs/bbs-busy.seq -p 6400 &

sleep 60

cd zoomfloppy

date >> $FILEOUT

#bash backupbbs.sh
#echo "...backup complete" >> $FILEOUT

bash updatenews.sh
#echo "...update complete" >> $FILEOUT

cd ..

pkill tcpser

nohup bash bbs-session.sh >> bbs-session.log &





