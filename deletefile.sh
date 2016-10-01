#!/bin/bash

FILE="$1"

echo "$FILE"

bash resetusb.sh
sleep 1
cbmctrl -p command 8 "s0:$FILE"
sleep 1
bash resetusb.sh
