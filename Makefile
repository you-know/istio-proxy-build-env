debug-arm:
    docker run -it -e=ISTIO_PROXY_VERSION=1.6.1 morlay/istio-proxy-build-env:latest-arm64

rebuild-build-env:
	git tag -f build-env && git push -f origin build-env
	