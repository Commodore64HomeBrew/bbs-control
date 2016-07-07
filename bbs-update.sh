#!/bin/bash

FILENUM=$(shuf -i 1-6 -n 1)

cat seqs/connect-msg.seq > bbs-update.seq
cat seqs/$FILENUM-logo.seq >> bbs-update.seq
cat seqs/update-msg.seq >> bbs-update.seq

sh killsession.sh

tcpser -v 25232 -s 1200 -tsS -l 7  -a seqs/bbs-update.seq  -p 6400 &

sh zoomfloppy/backupbbs.sh

sh zoomfloppy/updatenews.sh

pkill tcpser

nohup sh bbs-session-new.sh >> bbs-session.log &





