#!/bin/bash

DEVICE=$(lsusb | grep "GrauTec" | awk -F ' ' '{print "/dev/bus/usb/"$2"/"$4}' | sed 's/://')

./usbreset $DEVICE

