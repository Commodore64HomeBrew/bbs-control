


IP=207.34.151.66


LATLON=$(wget -o /dev/null -O - http://freegeoip.net/xml/$IP | awk -F'<|>' '/Latitude|Longitude/ {print $3}')

LAT=$(cut -f1 -d" " <<< $LATLON)
LON=$(cut -f2 -d" " <<< $LATLON)

echo "Latitude: " $LAT
echo "Longitude:" $LON


