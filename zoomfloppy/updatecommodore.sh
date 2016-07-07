#!/bin/bash

#sh dummyconnect.sh &

sh commodorenews.sh

sh 1571side.sh 1

sh deletefile.sh "(bbs-l3)"

echo "Old files deleted"

sh writefile.sh "(bbs-l3)"

echo "New files written"

sh 1571side.sh 0

cbmctrl reset

#pkill telnet

