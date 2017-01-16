#!/bin/bash
DEVICE=/dev/ttyAMA0
PORT=6400
FILENAME="session2.log"
ESTAB="ESTAB"
TIMEOUT=60
X=1

sudo /usr/local/bin/noip2

pkill tcpser2
nohup ./tcpser2 -d $DEVICE -s 2400 -tsS -l 7 -i "s0=1&s2=43&e0q0v0&c0x1&k0&w" -a seqs/bbs-welcome.seq -T seqs/bbs-timeout.seq -B seqs/bbs-busy.seq -p $PORT -I > $FILENAME &


#./tcpser2 -d $DEVICE -s 2400 -tsS -l 7 -i "s0=1&s2=43&e0q0v0&c0x1&k0&w" -I -a seqs/bbs-welcome.seq -T seqs/bbs-timeout.seq -B seqs/bbs-busy.seq -p 2000 > $FILENAME &

while [ "$X" -gt 0 ]; do

	FILENUM=$(shuf -i 1-6 -n 1)

	cat seqs/connect-msg.seq > seqs/bbs-welcome.seq
	cat seqs/$FILENUM-logo.seq >> seqs/bbs-welcome.seq
	#cat seqs/connect-status.seq >> seqs/bbs-welcome.seq
	
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
			
			SIZEONE=$SIZETWO
                	SIZETWO=$(stat -c%s "$FILENAME")

                	if [ $SIZEONE -eq $SIZETWO ]
                	then
                        	QUIET=$(( SECONDS - START ))

                        	if [ $QUIET -gt $TIMEOUT ]
                        	then
                                	echo "...timeout"
                                	HANGUP=1
                        	fi
                	else
                        	START=$SECONDS
                	fi
		fi


		if [ $PROTOSENT -eq 0 ]
		then
			TRNSFR=$(tail -50 $FILENAME | grep '|)               |')
	
			if [ -n "$TRNSFR" ]
			then
				echo "...protocol change"
				perl -C -e 'print "2"' > $DEVICE; sleep 1.2; perl -C -e 'print "P"' > $DEVICE
				PROTOSENT=1
			fi
		fi


		if [ $PROTOSENT -eq 1 ]
		then

			DEIGHT=$(tail -10 $FILENAME | grep '|> .(.8..        |')

			if [ -n "$DEIGHT" ]
			then
				echo "...drive 8 switch"
				perl -C -e 'print "2"' > $DEVICE
			fi
		fi

		#PLUSES=$(tail -100 $FILENAME | grep '|+++             |')

		#if [ -n "$PLUSES" ]
		#then
		#	echo "...hangup"
		#	HANGUP=1
		#fi

	
		#tail -f session.log | grep -m 1 "|XXXX            |" | xargs perl -C -e 'print "123-456-7890^M"' > $DEVICE

		STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')

	done

	echo "$(date)"
		
	#> $FILENAME

done
