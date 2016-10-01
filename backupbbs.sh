#!/bin/bash

DATE=`date +%Y-%m-%d`

echo $DATE

bash 1571side.sh 0

d64copy -d 1541 -t original 8 "systemdisk-0-$DATE.d64"

bash 1571side.sh 1

d64copy -d 1541 -t original 8 "systemdisk-1-$DATE.d64"

bash 1571side.sh 0

cbmctrl reset

