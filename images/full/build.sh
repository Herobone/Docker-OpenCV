#!/bin/sh
OPENCV_VERSION=$(curl -sX GET "https://api.github.com/repos/opencv/opencv/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
echo "Version: ${OPENCV_VERSION}"
DOCKER_BUILDKIT=1 docker build -t herobone/opencv:full -t herobone/opencv:latest -t "herobone/opencv:full-${OPENCV_VERSION}" .