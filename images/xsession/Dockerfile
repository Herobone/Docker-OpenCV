FROM herobone/opencv:full

RUN apt-get update && \
    apt-get install -y \
        sudo \
        git

ARG USERNAME=opencv
ENV UID 1000
ENV GID 1000

RUN adduser --gecos '' --disabled-password ${USERNAME} && \
    usermod --shell /bin/bash $USERNAME && \
    # set login shell
    usermod -aG sudo $USERNAME && \
    # allow sudo
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd && \
    # disable sudo password
    usermod  --uid ${UID} $USERNAME && \
    groupmod --gid ${GID} $USERNAME && \
    # set uid and gid of host user
    usermod -aG video ${USERNAME}

WORKDIR /home/${USERNAME}