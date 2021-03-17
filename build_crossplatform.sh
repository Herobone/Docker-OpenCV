#!/bin/sh
sudo apt install -y qemu-user-static binfmt-support
sudo docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
sudo docker buildx create --name sofia # name as you like
sudo docker buildx use sofia
sudo docker buildx inspect --bootstrap
OPENCV_VERSION=$(curl -sX GET "https://api.github.com/repos/opencv/opencv/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
echo "Version: ${OPENCV_VERSION}"
sudo docker buildx build --platform linux/arm64,linux/amd64 -t herobone/opencv:full -t herobone/opencv:latest -t "herobone/opencv:full_${OPENCV_VERSION}" --push images/full