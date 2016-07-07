#!/bin/bash
FILENAME="session.log"
ESTAB="ESTAB"
TIMEOUT=60
X=1

sudo /usr/local/bin/noip2

while [ "$X" -gt 0 ]; do

	FILENUM=$(shuf -i 1-6 -n 1)

	cat connect-msg.seq > bbs-welcome.seq
	cat $FILENUM-logo.seq >> bbs-welcome.seq
	cat connect-status.seq >> bbs-welcome.seq

        pkill tcpser
  
	 tcpser -d /dev/ttyAMA0 -s 1200 -tsS -l 7 -i "s0=1&s2=43&e0q0v0&c0x1&k0&w" -a /home/pi/CentronianBBS/bbs-welcome.seq -T /home/pi/CentronianBBS/bbs-timeout.seq -B /home/pi/CentronianBBS/bbs-busy.seq -p 6400 > $FILENAME &
	
	sleep 1
    	
	echo "...waiting for new connection"

	#STATUS=$(netstat -tn 2>/dev/null | grep :6400 | awk '{print $6}')
	STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')

	while [ "$STATUS" != "$ESTAB" ]; do
		sleep 1
		STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')
		#STATUS=$(netstat -tn 2>/dev/null | grep :6400 | awk '{print $6}')
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

	STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')

	while [ "$STATUS" = "$ESTAB" ] && [ $HANGUP -eq 0 ] ; do

		if [ $CHECKSENT -eq 0 ]
		then
			CGMODE=$(tail -50 $FILENAME | grep '|mode  >         |')

			if [ -n "$CGMODE" ]
			then
				echo "...checkmark sent"
				perl -C -e 'print chr 0xe1ba' > /dev/ttyAMA0
				CHECKSENT=1
			fi
		fi


		if [ $PROTOSENT -eq 0 ]
		then
			TRNSFR=$(tail -50 $FILENAME | grep '|)               |')
	
			if [ -n "$TRNSFR" ]
			then
				echo "...protocol change"
				perl -C -e 'print "2^M"' > /dev/ttyAMA0; sleep 1.2; perl -C -e 'print "P^M"' > /dev/ttyAMA0
				PROTOSENT=1
			fi
		fi


		if [ $PROTOSENT -eq 1 ]
		then

			DEIGHT=$(tail -10 $FILENAME | grep '|> .(.8..        |')

			if [ -n "$DEIGHT" ]
			then
				echo "...drive 8 switch"
				perl -C -e 'print "2^M"' > /dev/ttyAMA0
			fi
		fi

		PLUSES=$(tail -100 $FILENAME | grep '|+++             |')

		if [ -n "$PLUSES" ]
		then
			echo "...hangup"
			HANGUP=1
		fi

		SIZEONE=$SIZETWO
                SIZETWO=$(stat -c%s "$FILENAME")

                if [ $SIZEONE -eq $SIZETWO ]
		then
			QUIET=$SECONDS
			
			if [ $QUIET -gt $TIMEOUT ]
			then
				echo "...timeout"
				HANGUP=1
			fi

		else
			SECONDS=0
                fi
		#echo $QUIET

		#echo "$(ss -tp | grep 'tcpser')"
		#echo $(netstat -tn 2>/dev/null | grep :6400)
		STATUS=$(ss -tp | grep 'tcpser' | awk '{print $1}')

	done


	echo "$(date)"
		
	#tail -f session.log | grep -m 1 "|XXXX            |" | xargs perl -C -e 'print "123-456-7890"' > /dev/ttyAMA0


done
