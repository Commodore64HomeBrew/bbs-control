#!/bin/bash

wget http://rss.cbc.ca/lineup/topstories.xml

sed -i '/<language>/ d' topstories.xml
sed -i '/<lastBuildDate>/ d' topstories.xml
sed -i '/<guid/ d' topstories.xml

links -width 40 -dump topstories.xml | sed '/http/ d' | sed '/]]/ d' | tr 'a-zA-Z' 'A-Za-z' > "(bbs-l1)"
#links -width 40 -dump topstories.xml | sed '/http/ d' | sed '/]]/ d' > topstories.txt


rm topstories.xml

