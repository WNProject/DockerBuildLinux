FROM ubuntu:focal-20200925

# set input arguments
ARG COMPILER_PACKAGES
ARG C_COMPILER_NAME
ARG CPP_COMPILER_NAME

# install packages
RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      apt-utils \
      libx11-xcb-dev \
      libxcb-keysyms1-dev \
      python3 \
      cmake \
      make \
      ninja-build \
      ${COMPILER_PACKAGES} && \
    update-alternatives --install \
      /usr/bin/cc cc /usr/bin/${C_COMPILER_NAME} 100 && \
    update-alternatives --install \
      /usr/bin/c++ c++ /usr/bin/${CPP_COMPILER_NAME} 100 && \
    update-alternatives --install \
      /usr/bin/python python /usr/bin/python3 100 && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf \
      /var/lib/apt/lists/* \
      /var/tmp/* \
      /tmp/*

# default command
CMD ["bash"]

# labels
LABEL maintainer WNProject
LABEL org.opencontainers.image.source \
      https://github.com/WNProject/DockerBuildLinux
