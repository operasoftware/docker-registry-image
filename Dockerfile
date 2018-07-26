FROM registry:2.6 as base

FROM alpine:3.8

COPY --from=base /bin/registry /bin/registry
COPY --from=base /etc/docker/registry/config.yml /etc/docker/registry/config.yml
COPY --from=base /entrypoint.sh /entrypoint.sh

RUN set -eux \
 && apk add --update --no-cache \
    ca-certificates \
    apache2-utils

VOLUME ["/var/lib/registry"]
EXPOSE 5000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/etc/docker/registry/config.yml"]
