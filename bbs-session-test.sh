#!/bin/bash
DEVICE=/dev/ttyUSB0
PORT=6400
SPEED=2400
FILENAME="session2.log"
ESTAB="ESTAB"
TIMEOUT=60
X=1

#sudo /usr/local/bin/noip2

while [ "$X" -gt 0 ]; do

	FILENUM=$(shuf -i 1-6 -n 1)

	cat seqs/connect-msg.seq > seqs/bbs-welcome.seq
	cat seqs/$FILENUM-logo.seq >> seqs/bbs-welcome.seq
	cat seqs/connect-status.seq >> seqs/bbs-welcome.seq

	pkill tcpser2


	./tcpser2 -d $DEVICE -s $SPEED -tsS -l 7 -i "s0=1&e0q0v0&c0x1&k0&w" -a seqs/bbs-welcome.seq -T seqs/bbs-timeout.seq -B seqs/bbs-busy.seq -p $PORT -I > $FILENAME &
	
	sleep 1
    	
	echo "...waiting for new connection"

	STATUS=$(ss -tp | grep 'tcpser2' | awk '{print $1}')

	while [ "$STATUS" != "$ESTAB" ]; do
		sleep 1
		STATUS=$(ss -tp | grep 'tcpser2' | awk '{print $1}')
	done

	echo "$(ss -tp | grep 'tcpser2')"

	echo "$(date)"

        SIZEONE=$(stat -c%s "$FILENAME")
        SIZETWO=$SIZEONE


	START=$SECONDS
	while [ "$STATUS" = "$ESTAB" ] ; do

		STATUS=$(ss -tp | grep 'tcpser2' | awk '{print $1}')

	done

	echo "$(date)"

	sleep 2
		

done
