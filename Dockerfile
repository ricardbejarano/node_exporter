FROM alpine:3 AS build

ARG VERSION="1.0.1"
ARG CHECKSUM="3369b76cd2b0ba678b6d618deab320e565c3d93ccb5c2a0d5db51a53857768ae"

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
