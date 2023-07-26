#!/bin/sh

set -e

echo " "
echo " "

LATEST=$(curl -s https://api.github.com/repos/v2fly/v2ray-core/releases/latest | jq | grep tag_name | cut -d '"' -f 4)

docker buildx build \
    --platform linux/amd64 \
    --build-arg TAG=${LATEST} \
    --push \
    -t ${CI_REGISTRY}/gissily/v2fly-docker:${LATEST} \
    -t ${CI_REGISTRY}/gissily/v2fly-docker:latest \
    -f ${PROJECT_DIR}/Dockerfile . --no-cache