FROM debian AS build

ARG EXPORTER_VERSION="0.18.1"
ARG EXPORTER_CHECKSUM="b2503fd932f85f4e5baf161268854bf5d22001869b84f00fd2d1f57b51b72424"

ADD https://github.com/prometheus/node_exporter/releases/download/v$EXPORTER_VERSION/node_exporter-$EXPORTER_VERSION.linux-amd64.tar.gz /tmp/node_exporter.tar.gz

RUN [ "$EXPORTER_CHECKSUM" = "$(sha256sum /tmp/node_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/node_exporter.tar.gz && \
    mv /tmp/node_exporter-$EXPORTER_VERSION.linux-amd64 /tmp/node_exporter


FROM scratch

COPY --from=build /tmp/node_exporter/node_exporter /

COPY rootfs /

USER 100:100
EXPOSE 9100/tcp
ENTRYPOINT ["/node_exporter"]
