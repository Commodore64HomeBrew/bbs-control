#!/bin/bash

#sh dummyconnect.sh &

sh cbcnews.sh

sh 1571side.sh 1

sh deletefile.sh "(bbs-l5)"

echo "(bbs-l5) deleted"

sh writefile.sh "(bbs-l5)"

echo "(bbs-l5) written"

sh 1571side.sh 0

cbmctrl reset

#pkill telnet

