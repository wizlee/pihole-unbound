#!/bin/bash
# The command below is not needed, remain here as a FYI
# Explanation: This command creates a new builder instance named build, sets it as the current builder, specifies the name of the node as build, and sets the network mode to host for the driver.
# Run this once: docker buildx create --use --name build --node build --driver-opt network=host

# The commands below are the original command in build-and-push.sh, which is the original filename of this file
# docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t cbcrowe/pihole-unbound:$PIHOLE_VER --push .
# docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t cbcrowe/pihole-unbound:latest --push .

if [ -z "$1" ]; then
  echo "this script expects one argument for pihole-unbound image version"
fi

PIHOLE_VER=`cat PIHOLE_VERSION`
docker build --build-arg PIHOLE_VERSION=$PIHOLE_VER -t pihole-unbound:$1 .
