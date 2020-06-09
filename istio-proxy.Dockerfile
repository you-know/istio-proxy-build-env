ARG ARCH

FROM morlay/istio-proxy-build-env:latest-${ARCH} as builder

ARG TARGETARCH

ENV ISTIO_PROXY_VERSION 1.6.0

RUN set -eux; \
    \
    wget https://github.com/istio/proxy/archive/${ISTIO_PROXY_VERSION}.zip; \
    unzip ./${ISTIO_PROXY_VERSION}.zip; \
    mkdir -p /go/src; \
    mv ./proxy-${ISTIO_PROXY_VERSION}/ /go/src/proxy; \
    cd /go/src/proxy; \
    git config --global user.email "you@example.com"; \
    git init && git add . && git commit -m "init";

WORKDIR /go/src/proxy

RUN set -eux; \
    \
    export JAVA_HOME="$(dirname $(dirname $(realpath $(which javac))))"; \
    make build_envoy;

FROM busybox

COPY --from=builder /proxy /proxy