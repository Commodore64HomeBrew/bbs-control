#!/bin/bash

bash resetusb.sh

cbmctrl command 8 "U0>M0"

bash resetusb.sh

if [ $1 -eq 0 ]
then
	cbmctrl command 8 "U0>H0"
	echo "switched to side 0"
fi

if [ $1 -eq 1 ]
then
        cbmctrl command 8 "U0>H1"
	echo "switched to side 1"
fi


