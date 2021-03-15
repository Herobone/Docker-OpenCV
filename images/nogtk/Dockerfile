FROM debian:10
RUN apt-get update && \
    apt-get install -y --no-install-recommends\
        curl \
        cmake g++ gcc \
        python3 python3-dev python3-numpy \
        # Image libs
        libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev \
        git

RUN \
    echo "*** cloning opencv ***" && \
    mkdir -p .tmp/opencv && \
    git clone --progress --verbose https://github.com/opencv/opencv.git .tmp/opencv && \
    mkdir -p .tmp/opencv-contrib && \
    git clone --progress --verbose https://github.com/opencv/opencv_contrib.git .tmp/opencv-contrib

RUN \
    echo "*** building opencv ***" && \
    mkdir -p .tmp/build && cd .tmp/build && \
    cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv-contrib/modules ../opencv && \
    make -j6 && \
    echo "*** installing opencv ***" && \
    make install

RUN \
    echo "*** cleanup ***" && \
    rm -r .tmp && \
    rm -rf /var/lib/apt/lists/*