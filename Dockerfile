FROM ubuntu:focal-20220316

# set input arguments
ARG CMAKE_VERSION="3.16.3"
ARG COMPILER_PACKAGES
ARG C_COMPILER_NAME
ARG CPP_COMPILER_NAME

# set basic environment variables
ENV HOME="/root" \
    TERM="xterm"
ENV PATH="${PATH}:${HOME}/.cargo/bin"

# install packages
RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends --no-install-suggests -y \
      apt-utils \
      software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get install --no-install-recommends --no-install-suggests -y \
      ${COMPILER_PACKAGES} \
      ca-certificates \
      cmake=${CMAKE_VERSION}* \
      curl \
      git \
      libssl-dev \
      libx11-xcb-dev \
      libxcb-keysyms1-dev \
      make \
      ninja-build \
      pkg-config \
      python3 && \
    update-alternatives --install \
      /usr/bin/cc cc /usr/bin/${C_COMPILER_NAME} 100 && \
    update-alternatives --install \
      /usr/bin/c++ c++ /usr/bin/${CPP_COMPILER_NAME} 100 && \
    update-alternatives --install \
      /usr/bin/python python /usr/bin/python3 100 && \
    curl -sSf https://sh.rustup.rs | sh -s -- -y && \
    cargo install sccache --features=gcs && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf \
      ${HOME}/.cargo/registry \
      ${HOME}/.cargo/git \
      /var/lib/apt/lists/* \
      /var/tmp/* \
      /tmp/*

# default command
CMD ["bash"]

# labels
LABEL maintainer WNProject \
      org.opencontainers.image.source \
        https://github.com/WNProject/DockerBuildLinux
