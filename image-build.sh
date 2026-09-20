#!/bin/sh

set -e

echo " "
echo " "

LATEST=$(curl -s https://api.github.com/repos/v2fly/v2ray-core/releases/latest | jq | grep tag_name | cut -d '"' -f 4)

docker buildx bake -f docker-bake.hcl --pull --push --no-cache