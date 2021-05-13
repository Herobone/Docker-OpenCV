FROM debian:stable-slim as builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl git unzip ca-certificates \
        cmake g++ gcc ninja-build \
        python3 python3-dev python3-numpy \
        libavcodec-dev libavformat-dev libswscale-dev libavutil-dev \
        # GTK Support
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
    cmake \
        -DOPENCV_EXTRA_MODULES_PATH=../opencv-contrib/modules \
        -DWITH_FFMPEG=ON \
        -DBUILD_TESTS=OFF \
        -DBUILD_PERF_TESTS=OFF \
        -GNinja ../opencv && \
    ninja

RUN \
    echo "*** installing opencv ***" && \
    cd .tmp/build && \
    ninja install

FROM debian:stable-slim as release

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
        python3 python3-numpy \
        libavcodec-dev libavformat-dev libswscale-dev libavutil-dev \
        cmake g++ gcc

RUN apt-get install -y --no-install-recommends \
        libgtk-3-dev && \
	rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include/opencv4 /usr/local/include/opencv4
COPY --from=builder /usr/local/share/opencv4 /usr/local/share/opencv4
