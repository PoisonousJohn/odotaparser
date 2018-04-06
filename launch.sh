#!/bin/sh
REPLAY_FILE=$1
echo "Launching server"
java -jar -Xmx150m /usr/src/parser/target/stats-0.1.0.jar 5600 &
wget -O replay.dem.bz2 $REPLAY_FILE
echo "Extracting"
bzip2 -d replay.dem.bz2
curl localhost:5600 --data-binary "@replay.dem" > export.json

