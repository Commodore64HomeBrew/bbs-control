#!/bin/bash

DATE=`date +%Y-%m-%d`

bash 1571side.sh 0

d64copy -d 1541  8 "systemdisk-0-$DATE.d64"

bash 1571side.sh 1

d64copy -d 1541  8 "systemdisk-1-$DATE.d64"

bash 1571side.sh 0

cbmctrl reset

#hub-ctrl -h 0 -P 3 -p 0
