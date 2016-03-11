FROM tray/busybox:latest

ENV HEKA_VERSION 0_10_0

ADD heka-${HEKA_VERSION}-linux-amd64.tar.gz /
RUN mv /heka-${HEKA_VERSION}-linux-amd64/share/* /usr/share/.

COPY logentries.lua /usr/share/heka/lua_encoders/logentries.lua
COPY logentries.toml /tmp/logentries.toml

# cp /etc/ssl/certs/ca-bundle.crt ca-bundle.crt
COPY ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
