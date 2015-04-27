#!/bin/sh

TOKEN=$1
if [ "x${TOKEN}" = "x" ]; then
    echo "Missing token parameter."
    exit 1
fi

sed -i.bak -e "s/%TOKEN%/${TOKEN}/" /tmp/logentries.toml
exec /heka-0_9_2-linux-amd64/bin/hekad -config /tmp/logentries.toml
