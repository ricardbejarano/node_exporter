FROM alpine:3 AS build

ARG VERSION="0.18.1"
ARG CHECKSUM="b2503fd932f85f4e5baf161268854bf5d22001869b84f00fd2d1f57b51b72424"

ADD https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz /tmp/node_exporter.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/node_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/node_exporter.tar.gz && \
    mv /tmp/node_exporter-$VERSION.linux-amd64 /tmp/node_exporter

RUN echo "nogroup:*:100:nobody" > /tmp/group && \
    echo "nobody:*:100:100:::" > /tmp/passwd


FROM scratch

COPY --from=build --chown=100:100 /tmp/node_exporter/node_exporter /
COPY --from=build --chown=100:100 /tmp/group \
                                  /tmp/passwd \
                                  /etc/

USER 100:100
EXPOSE 9100/tcp
ENTRYPOINT ["/node_exporter"]
