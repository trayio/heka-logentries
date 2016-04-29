#!/bin/sh

TOKEN=$1
if [ "x${TOKEN}" = "x" ]; then
    echo "Missing token parameter."
    exit 1
fi

IP=$2

sed -i.bak -e "s/%TOKEN%/${TOKEN}/" -e "s/%IP_ADDRESS%/${IP}/" /tmp/logentries.toml
exec /heka-${HEKA_VERSION}-linux-amd64/bin/hekad -config /tmp/logentries.toml
