#!/bin/sh
OPENCV_VERSION=$(curl -sX GET "https://api.github.com/repos/opencv/opencv/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
echo "Version: ${OPENCV_VERSION}"
docker buildx build --platform linux/amd64,linux/arm64 --push -t herobone/opencv:python -t "herobone/opencv:python-${OPENCV_VERSION}" .