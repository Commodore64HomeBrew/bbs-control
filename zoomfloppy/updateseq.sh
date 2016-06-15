#!/bin/bash

FILE="$1"

sh resetusb.sh

cbmctrl -p command 8 "s0:$FILE"

sleep 15


sh resetusb.sh

cbmcopy -t original -w 8 --file-type=S $FILE

sleep 5

