#!/bin/bash

bash cbcnews.sh
bash nasanews.sh

bash 1571side.sh 1

bash deletefile.sh "(bbs-l1)"
bash deletefile.sh "(bbs-l2)"

echo "Old files deleted"

bash writefile.sh "(bbs-l1)"
bash writefile.sh "(bbs-l2)"

echo "New files written"

bash 1571side.sh 0

cbmctrl reset

