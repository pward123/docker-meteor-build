#!/bin/bash
set -e

# Pull the tag from the circle branch
TAG=$(echo ${CIRCLE_BRANCH} | sed 's/release\/v//' | sed 's/feature\///')

# Tag the built docker containers
docker tag meteor-build:latest meteor-build:$TAG

# Create the temporary folder we use to build the .tar
DISTRO_DIR=/tmp/distro
mkdir -p ${DISTRO_DIR}

# Copy compressed versions of the container(s) to the distro folder
docker save meteor-build:$TAG | gzip -c > ${DISTRO_DIR}/meteor-build_${TAG}.tgz

# Copy the tar to AWS
aws s3 cp meteor-build_${TAG}.tgz s3://savi-docker-images/base-images/meteor-build_${TAG}.tgz
