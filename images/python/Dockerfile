FROM herobone/opencv

RUN \
    echo "*** cleanup ***" && \
    apt-get remove cmake g++ gcc -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*