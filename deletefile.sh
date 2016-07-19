#!/bin/bash

FILE="$1"

echo "$FILE"
bash resetusb.sh

cbmctrl -p command 8 "s0:$FILE"

sleep 15
