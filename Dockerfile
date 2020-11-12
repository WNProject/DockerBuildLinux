FROM ubuntu:focal-20201008

# set input arguments
ARG CMAKE_VERSION="3.16.3"
ARG COMPILER_PACKAGES
ARG C_COMPILER_NAME
ARG CPP_COMPILER_NAME

# install packages
RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      apt-utils \
      git \
      libx11-xcb-dev \
      libxcb-keysyms1-dev \
      python3 \
      cmake=${CMAKE_VERSION}* \
      make \
      ninja-build \
      libssl-dev \
      pkg-config \
      curl \
      ${COMPILER_PACKAGES} && \
    update-alternatives --install \
      /usr/bin/cc cc /usr/bin/${C_COMPILER_NAME} 100 && \
    update-alternatives --install \
      /usr/bin/c++ c++ /usr/bin/${CPP_COMPILER_NAME} 100 && \
    update-alternatives --install \
      /usr/bin/python python /usr/bin/python3 100 && \
    curl -sSf -L https://sh.rustup.rs -o /tmp/rs.sh && \
    chmod +x /tmp/rs.sh && \
    /tmp/rs.sh -y && \
    $HOME/.cargo/bin/cargo install sccache --features=gcs && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf \
      ${HOME}/.cargo/registry \
      /var/lib/apt/lists/* \
      /var/tmp/* \
      /tmp/*

# default command
CMD ["bash"]

# labels
LABEL maintainer WNProject
LABEL org.opencontainers.image.source \
      https://github.com/WNProject/DockerBuildLinux
