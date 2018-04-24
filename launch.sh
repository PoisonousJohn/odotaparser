#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Launching script $DIR/job.sh"
$DIR/job.sh > stdout.txt 2> stderr.txt
if [ $? -ne 0 ]
then
    echo "Marking job as failed"
    curl -X POST -H "Content-type: text" -d @stderr.txt $FAIL_URL
fi

echo "Done"
