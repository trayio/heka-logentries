FROM progrium/busybox:latest

# https://github.com/mozilla-services/heka/releases/download/v0.9.2/heka-0_9_2-linux-amd64.tar.gz
ADD heka-0_9_2-linux-amd64.tar.gz /
RUN mv /heka-0_9_2-linux-amd64/share/* /usr/share/.

COPY logentries.lua /usr/share/heka/lua_encoders/logentries.lua
COPY logentries.toml /tmp/logentries.toml

# cp /etc/ssl/certs/ca-bundle.crt ca-bundle.crt
COPY ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
