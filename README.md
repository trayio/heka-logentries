### Docker + Heka + Logentries

#### Inputs

Each branch uses a different input

[master](https://github.com/trayio/heka-logentries/tree/master): [Logstreamer Input](https://hekad.readthedocs.org/en/latest/config/inputs/logstreamer.html)

[docker-log-input](https://github.com/trayio/heka-logentries/tree/docker-log-input): [DockerLogInput](https://hekad.readthedocs.org/en/latest/config/inputs/docker_log.html)

Follows logs in /var/lib/docker and sends them to Logentries using token based TCP + TLS.

#### Run

```bash
$ docker run -d -ti --restart always -v /var/lib/docker:/var/lib/docker:ro tray/heka-logentries <token>
```
