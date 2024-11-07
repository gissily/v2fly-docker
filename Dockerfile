FROM --platform=${TARGETPLATFORM} ubuntu:noble AS builder

ARG TARGETPLATFORM
ARG TAG

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        unzip \
        wget \
    ; \
    apt-get clean ; \
    apt-get -y autoclean ; \
    apt-get -y autoremove ; \
    rm -rf /var/lib/apt/lists/* ;

WORKDIR /build

RUN git clone https://github.com/v2fly/docker.git ;\
    mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray ; \
    ln -sf /dev/stdout /var/log/v2ray/access.log ; \
    ln -sf /dev/stderr /var/log/v2ray/error.log ; \
    chmod +x /build/docker/v2ray.sh ; \
    /build/docker/v2ray.sh "${TARGETPLATFORM}" "${TAG}"


FROM --platform=${TARGETPLATFORM} ubuntu:noble

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        iproute2 \
        iptables \
    ; \
    apt-get clean ; \
    apt-get -y autoclean ; \
    apt-get -y autoremove ; \
    rm -rf /var/lib/apt/lists/* ; \
    mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray ; \
    ln -sf /dev/stdout /var/log/v2ray/access.log ; \
    ln -sf /dev/stderr /var/log/v2ray/error.log ;

COPY --from=builder /usr/bin/v2ray /usr/bin/v2ray
COPY --from=builder /usr/local/share/v2ray /usr/local/share/v2ray
COPY --from=builder /etc/v2ray/config.json /etc/v2ray/config.json

WORKDIR /etc/v2ray/

ENTRYPOINT ["/usr/bin/v2ray"]