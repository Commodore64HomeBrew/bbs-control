#!/bin/bash
DEVICE=/dev/ttyAMA0
PORT=6400
FILENAME="/tmp/session.log"
ESTAB="ESTAB"
TIMEOUT=60
X=1

sudo /usr/local/bin/noip2

pkill tcpser
nohup tcpser -d $DEVICE -s 2400 -I -tsS -l 7 -i "s0=1&s7=30&e0m0v0c0x1&k0&w" -a seqs/bbs-welcome.seq -T seqs/bbs-timeout.seq -B seqs/bbs-busy.seq -p $PORT > $FILENAME &

while [ "$X" -gt 0 ]; do

	FILENUM=$(shuf -i 1-8 -n 1)

	cat seqs/connect-msg.seq > seqs/bbs-welcome.seq
	cat seqs/$FILENUM-logo.seq >> seqs/bbs-welcome.seq
	cat seqs/connect-status.seq >> seqs/bbs-welcome.seq
	
	echo "...waiting for new connection"
	
	#sudo nohup tcpdump -i eth0 'port 2300' > tcpdump.log &

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
	#sleep 6
	#sudo pkill tcpdump

        #ASCII=$(grep '2300' tcpdump.log | tail -5)
	ASCII=$(ss -tp | grep '162.253.176.32')
	if [ "$ASCII" != "" ]
	then
		echo "...ASCII mode"
	else
		sleep 6
	fi

	START=$SECONDS
	while [ "$STATUS" = "$ESTAB" ] && [ $HANGUP -eq 0 ] ; do

		if [ $CHECKSENT -eq 0 ]
		then
			CGMODE=$(tail -50 $FILENAME | grep '> ')

			if [ -n "$CGMODE" ]
			then
				if [ "$ASCII" = "" ]
				then
					echo "...checkmark sent"
					perl -C -e 'print chr 0xe1ba' > $DEVICE
				else
					echo "...CR sent"
					perl -C -e 'print "\n"' > $DEVICE
					sleep 1
					perl -C -e 'print "y\n"' > $DEVICE
				fi
				CHECKSENT=1
			fi	
		fi

		STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')

	done

	echo "$(date)"
done
