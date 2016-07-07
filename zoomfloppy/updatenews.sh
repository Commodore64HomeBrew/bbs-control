#!/bin/bash

#sh dummyconnect.sh &

sh cbcnews.sh
sh nasanews.sh

sh 1571side.sh 1

sh deletefile.sh "(bbs-l1)"
sh deletefile.sh "(bbs-l2)"

echo "Old files deleted"

sh writefile.sh "(bbs-l1)"
sh writefile.sh "(bbs-l2)"

echo "New files written"

sh 1571side.sh 0

cbmctrl reset

#pkill telnet

