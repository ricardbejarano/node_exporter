<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire-extinguisher_1f9ef.png width=120px></p>
<h1 align=center>node_exporter (container image)</h1>
<p align=center>The simplest container image of the official Prometheus <a href=https://github.com/prometheus/node_exporter>node_exporter</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/node_exporter`](https://hub.docker.com/r/ricardbejarano/node_exporter):

- [`0.18.1`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/node_exporter/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/node_exporter`](https://quay.io/repository/ricardbejarano/node_exporter):

- [`0.18.1`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/node_exporter/blob/master/Dockerfile)


## Features

* Super tiny (`~16.9MB`)
* Binary pulled from official website
* Built `FROM scratch`, see [Filesystem](#filesystem) for an exhaustive list of the image's contents
* Reduced attack surface (no shell, no UNIX tools, no package manager...)


## Building

```bash
docker build -t node_exporter .
```


## Filesystem

The images' contents are:

```
/
├── etc/
│   ├── group
│   └── passwd
└── node_exporter
```


## License

See [LICENSE](https://github.com/ricardbejarano/node_exporter/blob/master/LICENSE).
