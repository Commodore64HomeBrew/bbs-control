#!/bin/bash

hub-ctrl -h 0 -P 3 -p 1

sleep 2

sh cbcnews.sh

sh 1571side.sh 1

sh deletefile.sh "(bbs-l1)"

echo "(bbs-l1) deleted"

sh writefile.sh "(bbs-l1)"

echo "(bbs-l1) written"

hub-ctrl -h 0 -P 3 -p 0



