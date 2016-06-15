#!/bin/bash

DEVICE=$(lsusb | grep "ZoomFloppy" | awk -F ' ' '{print "/dev/bus/usb/"$2"/"$4}' | sed 's/://')

./usbreset $DEVICE

