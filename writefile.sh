#!/bin/bash

FILE="$1"

bash resetusb.sh
sleep 1
cbmcopy -t original -d 1541 -w 8 --file-type=S $FILE
sleep 1
bash resetusb.sh
