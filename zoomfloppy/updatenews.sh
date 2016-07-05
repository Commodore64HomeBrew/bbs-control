#!/bin/bash

#sh dummyconnect.sh &

sh cbcnews.sh
sh nasanews.sh

sh 1571side.sh 1

sh deletefile.sh "(bbs-l5)"
sh deletefile.sh "(bbs-l6)"

echo "Old files deleted"

sh writefile.sh "(bbs-l5)"
sh writefile.sh "(bbs-l6)"

echo "New files written"

sh 1571side.sh 0

cbmctrl reset

#pkill telnet

