### Docker + Heka + Logentries

#### Run

```bash
$ docker run -d -ti --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker:ro tray/heka-logentries <token>
```
