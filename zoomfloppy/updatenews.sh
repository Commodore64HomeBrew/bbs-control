#!/bin/bash

#hub-ctrl -h 0 -P 3 -p 1

sleep 2

sh cbcnews.sh

sh 1571side.sh 1

sh deletefile.sh "(bbs-l5)"

echo "(bbs-l5) deleted"

sh writefile.sh "(bbs-l5)"

echo "(bbs-l5) written"

sh 1571side.sh 0

cbmctrl reset

#hub-ctrl -h 0 -P 3 -p 0



