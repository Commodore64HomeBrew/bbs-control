#!/bin/bash

bash cbcnews.sh
bash nasanews.sh
bash commodorenews.sh

#bash 1571side.sh 1
bash resetusb.sh
sleep 1
cbmctrl reset
sleep 2

bash deletefile.sh "(bbs-l1)"
bash deletefile.sh "(bbs-l2)"
bash deletefile.sh "(bbs-l3)"

echo "Old files deleted"

bash writefile.sh "(bbs-l1)"
bash writefile.sh "(bbs-l2)"
bash writefile.sh "(bbs-l3)"

echo "New files written"

#bash 1571side.sh 0

cbmctrl reset
sleep 2
bash resetusb.sh
