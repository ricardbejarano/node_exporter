FROM alpine:3 AS build

ARG VERSION="0.18.1"
ARG CHECKSUM="b2503fd932f85f4e5baf161268854bf5d22001869b84f00fd2d1f57b51b72424"

ADD https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz /tmp/node_exporter.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/node_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/node_exporter.tar.gz

RUN mkdir -p /rootfs/etc && \
    cp /tmp/node_exporter-$VERSION.linux-amd64/node_exporter /rootfs/ && \
    echo "nogroup:*:100:nobody" > /rootfs/etc/group && \
    echo "nobody:*:100:100:::" > /rootfs/etc/passwd


FROM scratch

COPY --from=build --chown=100:100 /rootfs /

USER 100:100
EXPOSE 9100/tcp
ENTRYPOINT ["/node_exporter"]
