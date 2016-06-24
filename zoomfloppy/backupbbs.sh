#!/bin/bash

DATE=`date +%Y-%m-%d`

hub-ctrl -h 0 -P 3 -p 1

sh 1571side.sh 0

d64copy -d 1541  8 "systemdisk-0-$DATE.d64"

sh 1571side.sh 1

d64copy -d 1541  8 "systemdisk-1-$DATE.d64"

hub-ctrl -h 0 -P 3 -p 0
