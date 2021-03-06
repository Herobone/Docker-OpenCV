FROM debian:stable-slim as builder
RUN apt-get update && \
    apt-get install -y \
        curl unzip \
        cmake g++ gcc ninja-build \
        python3 python3-dev python3-numpy \
        # GTK Support
        libavcodec-dev libavformat-dev libswscale-dev \
        libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
        libgtk-3-dev

RUN \
    echo "*** cloning opencv ***" && \
    mkdir .tmp && \
    curl -fSL -o .tmp/opencv.zip https://github.com/opencv/opencv/archive/master.zip && \
    unzip -q .tmp/opencv.zip && mv opencv-master .tmp/opencv && \
    curl -fSL -o .tmp/opencv-contrib.zip https://github.com/opencv/opencv_contrib/archive/master.zip && \
    unzip -q .tmp/opencv-contrib.zip && mv opencv_contrib-master .tmp/opencv-contrib
RUN \
    echo "*** building opencv ***" && \
    mkdir -p .tmp/build && cd .tmp/build && \
    cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv-contrib/modules \ 
        -DBUILD_TESTS=OFF \
        -DBUILD_PERF_TESTS=OFF \
        -GNinja ../opencv && \
    ninja

RUN \
    echo "*** installing opencv ***" && \
    cd .tmp/build && \
    ninja install && \
    rm -r /usr/local/lib/cmake

FROM debian:stable-slim

RUN apt-get update &&\
    apt-get install -y \
        libavcodec-dev libavformat-dev libswscale-dev \
        libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
        python3 python3-numpy

RUN apt-get install -y \
        libgtk-3-dev

COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/share/opencv4 /usr/local/share/opencv4

RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT /usr/bin/python3