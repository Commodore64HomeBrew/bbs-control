#!/bin/bash

FILEOUT="goodbye.seq"
DIR=ppotd

files=($DIR/*)
printf "%s\n" "${files[RANDOM % ${#files[@]}]}"


PIC=${files[RANDOM % ${#files[@]}]}
echo -e "\x8e\x81\x0dpetscii pic of the day\x0d" > $FILEOUT

echo -e "\x9f\x0d$PIC\x0d" >> $FILEOUT

cat "$PIC" >> "$FILEOUT"

