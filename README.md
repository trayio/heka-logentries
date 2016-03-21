### Docker + Heka + Logentries

Follows logs in /var/lib/docker and sends them to Logentries using token based TCP + TLS.

#### Run

```bash
$ docker run -d -ti --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker:ro tray/heka-logentries <token>
```
