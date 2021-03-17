FROM alpine:3 as builder
RUN apk add --no-cache \
    curl unzip \
    cmake g++ gcc ninja \
    python3-dev python3 py3-numpy \
    linux-headers

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
    cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv-contrib/modules -GNinja ../opencv && \
    ninja

RUN \
    echo "*** installing opencv ***" && \
    cd .tmp/build && \
    ninja install

FROM alpine:3

RUN apk add --no-cache \
    python3 py3-numpy \
    cmake g++ gcc ninja

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include/opencv4 /usr/local/include/opencv4
COPY --from=builder /usr/local/share/opencv4 /usr/local/share/opencv4