FROM golang:1-alpine AS build

ARG VERSION="1.6.0"
ARG CHECKSUM="4e3e1f3f2f9a1d78c12752e055a0d0c809dcebf25c71325302fca1c759648eda"

ADD https://github.com/prometheus/node_exporter/archive/v$VERSION.tar.gz /tmp/node_exporter.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/node_exporter.tar.gz | awk '{print $1}')" ] && \
    apk add curl make && \
    tar -C /tmp -xf /tmp/node_exporter.tar.gz && \
    mkdir -p /go/src/github.com/prometheus && \
    mv /tmp/node_exporter-$VERSION /go/src/github.com/prometheus/node_exporter && \
    cd /go/src/github.com/prometheus/node_exporter && \
      make build

RUN mkdir -p /rootfs/bin && \
      cp /go/src/github.com/prometheus/node_exporter/node_exporter /rootfs/bin/ && \
    mkdir -p /rootfs/etc && \
      echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
      echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd


FROM scratch

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
EXPOSE 9100/tcp
ENTRYPOINT ["/bin/node_exporter"]
