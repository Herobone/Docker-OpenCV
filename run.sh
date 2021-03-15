#!/bin/bash
docker run -it \
    --env DISPLAY --env QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --device=/dev/video0:/dev/video0 \
    herobone/opencv:full