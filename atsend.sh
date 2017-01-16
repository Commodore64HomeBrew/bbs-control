#!/bin/bash

RETURN=$(perl -C -e 'print chr 0x000d')

perl -C -e 'print "atm0e0v0x1s0=1$RETURN"' > /dev/ttyAMA0

