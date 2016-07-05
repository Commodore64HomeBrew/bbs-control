#!/bin/bash

FILEOUT="(bbs-l7)"
FILEIN="http://www.commodore-news.com/news/index/1/en"

RETURN=$(perl -C -e 'print chr 0x000d')

RED=$(perl -C -e 'print chr 0xf101')
GREEN=$(perl -C -e 'print chr 0xf10d')
YELLOW=$(perl -C -e 'print chr 0xf10f')

rm $FILEOUT

#wget https://www.nasa.gov/rss/dyn/breaking_news.rss

#sed -i '/<language>/ d' $FILEIN
#sed -i '/<lastBuildDate>/ d' $FILEIN
#sed -i '/<guid/ d' $FILEIN

#echo $RED'cbc nEWS rss fEED'$YELLOW > $FILEOUT

links -width 40 -dump $FILEIN | sed '/http/ d' | sed '/]]/ d' | tr 'a-zA-Z' 'A-Za-z' >> $FILEOUT

#sed -i ':a;N;$!ba;s/\n\n/'$RED'\n\n/2' $FILEOUT

#sed -i ':a;N;$!ba;s/\n\n/'$GREEN'\n\n/g' $FILEOUT

sed -i ':a;N;$!ba;s/\n/'$RETURN'/g' $FILEOUT

#rm $FILEIN
