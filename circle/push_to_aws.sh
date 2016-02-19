#!/bin/bash
set -e

CONTAINER='meteor-build'

# Pull the tag from the circle branch
TAG=$(echo ${CIRCLE_BRANCH} | sed 's/release\/v//' | sed 's/feature\///')

# Tag the built docker containers
docker tag ${CONTAINER}:latest ${CONTAINER}:$TAG

# Create the temporary folder we use to build the .tar
DISTRO_DIR=/tmp/distro
mkdir -p ${DISTRO_DIR}

# Copy compressed versions of the container(s) to the distro folder
docker save ${CONTAINER}:$TAG | gzip -c > ${DISTRO_DIR}/${CONTAINER}_${TAG}.tgz

# Copy the tar to AWS
aws s3 cp ${DISTRO_DIR}/${CONTAINER}_${TAG}.tgz ${S3_BUCKET_PATH}/${CONTAINER}_${TAG}.tgz
