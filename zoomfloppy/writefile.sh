#!/bin/bash

FILE="$1"

bash resetusb.sh

cbmcopy -t original -d 1541 -w 8 --file-type=S $FILE

