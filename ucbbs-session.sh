#!/bin/bash
DEVICE=/dev/ttyAMA0
PORT=6400
FILENAME="session2.log"
ESTAB="ESTAB"
TIMEOUT=60
X=1

sudo /usr/local/bin/noip2

pkill tcpser
nohup tcpser -d $DEVICE -s 2400 -tsS -l 7 -i "s0=1&s7=30&e0m0v0c0x1&k0&w" -a seqs/bbs-welcome.seq -T seqs/bbs-timeout.seq -B seqs/bbs-busy.seq -p $PORT > $FILENAME &

while [ "$X" -gt 0 ]; do

	FILENUM=$(shuf -i 1-8 -n 1)

	cat seqs/connect-msg.seq > seqs/bbs-welcome.seq
	cat seqs/$FILENUM-logo.seq >> seqs/bbs-welcome.seq
	cat seqs/connect-status.seq >> seqs/bbs-welcome.seq
	
	echo "...waiting for new connection"

	STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')

	while [ "$STATUS" != "$ESTAB" ]; do
		sleep 1
		STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')
	done

	echo "$(ss -tp | grep 'tcpser')"
	#echo $(netstat -tn 2>/dev/null | grep :6400)
	echo "$(date)"

        SIZEONE=$(stat -c%s "$FILENAME")
        SIZETWO=$SIZEONE

	CHECKSENT=0
	PROTOSENT=0
	SECONDS=0
	HANGUP=0
	QUIET=0

	START=$SECONDS
	while [ "$STATUS" = "$ESTAB" ] && [ $HANGUP -eq 0 ] ; do

		if [ $CHECKSENT -eq 0 ]
		then
			CGMODE=$(tail -10 $FILENAME | grep '> ')

			if [ -n "$CGMODE" ]
			then
				echo "...checkmark sent"
				perl -C -e 'print chr 0xe1ba' > $DEVICE
				CHECKSENT=1
			fi	
		fi

		STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')

	done

	echo "$(date)"

done
