#!/bin/bash

set -e

echo " "
echo " "

export LATEST=$(curl -s https://api.github.com/repos/v2fly/v2ray-core/releases/latest | jq | grep tag_name | cut -d '"' -f 4)

echo $CI_REGISTRY

docker buildx bake \
    -f ${PROJECT_DIR}/docker-bake.hcl \
    --pull \
    --push \
    --no-cache