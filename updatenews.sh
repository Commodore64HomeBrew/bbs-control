#!/bin/bash

bash cbcnews.sh
bash nasanews.sh
bash commodorenews.sh

cat seqs/pauseabort.seq l1 > "(info-1)"
cat seqs/pauseabort.seq l2 > "(info-2)"
cat seqs/pauseabort.seq l3 > "(info-3)"

#bash 1571side.sh 1
bash resetusb.sh
sleep 1
cbmctrl reset
sleep 2

bash deletefile.sh "(info-1)"
bash deletefile.sh "(info-2)"
bash deletefile.sh "(info-3)"

echo "Old files deleted"

bash writefile.sh "(info-1)"
bash writefile.sh "(info-2)"
bash writefile.sh "(info-3)"

echo "New files written"

#bash 1571side.sh 0

cbmctrl reset
sleep 2
bash resetusb.sh
