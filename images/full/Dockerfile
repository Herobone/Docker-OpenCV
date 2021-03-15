FROM debian:10
RUN apt-get update && \
    apt-get install -y \
        curl unzip \
        cmake g++ gcc \
        python3 python3-dev python3-numpy \
        # GTK Support
        libavcodec-dev libavformat-dev libswscale-dev \
        libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
        libgtk-3-dev \
        # Image libs
        libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev \
        git

RUN \
    echo "*** cloning opencv ***" && \
    mkdir .tmp && \
    curl -fSL -o .tmp/opencv.zip https://github.com/opencv/opencv/archive/master.zip && \
    unzip .tmp/opencv.zip && mv opencv-master .tmp/opencv && \
    curl -fSL -o .tmp/opencv-contrib.zip https://github.com/opencv/opencv_contrib/archive/master.zip && \
    unzip .tmp/opencv-contrib.zip && mv opencv_contrib-master .tmp/opencv-contrib && \
    echo "*** building opencv ***" && \
    mkdir -p .tmp/build && cd .tmp/build && \
    cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv-contrib/modules ../opencv && \
    make -j6 && \
    echo "*** installing opencv ***" && \
    make install && \
    echo "*** cleanup ***" && \
    cd / && rm -r .tmp && \
    rm -rf /var/lib/apt/lists/*
