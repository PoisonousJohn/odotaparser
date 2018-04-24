#!/bin/bash
set -e
set -o pipefail
echo "Launching server"
java -jar -Xmx150m /usr/src/parser/target/stats-0.1.0.jar 5600 &
aria2c -j 10 -o replay.dem.bz2 $REPLAY_FILE
echo "Extracting"
bzip2 -d replay.dem.bz2
curl localhost:5600 --data-binary "@replay.dem" > export.json
echo "Getting upload url"
UPLOAD_URL=`curl $URL`
# remove quotes from curl output
temp="${UPLOAD_URL%\"}"
UPLOAD_URL="${temp#\"}"
echo "Upload url: $UPLOAD_URL"
echo "Uploading file"
curl -H "Content-type: application/octet-stream" -H "x-ms-blob-type: BlockBlob" -X PUT -d @export.json "$UPLOAD_URL"
echo "All done"
