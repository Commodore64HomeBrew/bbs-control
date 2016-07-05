#!/bin/bash

FILEOUT="(bbs-l5)"

RETURN=$(perl -C -e 'print chr 0x000d')

RED=$(perl -C -e 'print chr 0xf101')
GREEN=$(perl -C -e 'print chr 0xf10d')
YELLOW=$(perl -C -e 'print chr 0xf10f')

rm $FILEOUT
rm topstories.xml

wget http://rss.cbc.ca/lineup/topstories.xml

sed -i '/<language>/ d' topstories.xml
sed -i '/<lastBuildDate>/ d' topstories.xml
sed -i '/<guid/ d' topstories.xml

#echo $RED'cbc nEWS rss fEED'$YELLOW > $FILEOUT

links -width 40 -dump topstories.xml | sed '/http/ d' | sed '/]]/ d' | tr 'a-zA-Z' 'A-Za-z' >> $FILEOUT
#links -width 40 -codepage en_US.UTF-8 -dump topstories.xml > $FILEOUT

#sed -i ':a;N;$!ba;s/\n\n/'$RED'\n\n/2' $FILEOUT

#sed -i ':a;N;$!ba;s/\n\n/'$GREEN'\n\n/g' $FILEOUT

sed -i ':a;N;$!ba;s/\n/'$RETURN'/g' $FILEOUT

