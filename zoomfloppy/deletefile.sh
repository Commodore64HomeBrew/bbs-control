#!/bin/bash

FILE="$1"

echo "$FILE"
sh resetusb.sh

cbmctrl -p command 8 "s0:$FILE"

sleep 15
