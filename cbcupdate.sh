#!/bin/bash

FILE="(bbs-l1)"

wget http://rss.cbc.ca/lineup/topstories.xml

sed -i '/<language>/ d' topstories.xml
sed -i '/<lastBuildDate>/ d' topstories.xml
sed -i '/<guid/ d' topstories.xml

links -width 40 -dump topstories.xml | sed '/http/ d' | sed '/]]/ d' | tr 'a-zA-Z' 'A-Za-z' > $FILE

rm topstories.xml

sh updatefile.sh $FILE
