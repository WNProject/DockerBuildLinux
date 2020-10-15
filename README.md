# Docker Build Linux

[![License]](LICENSE)
[![Build][Build Badge]][Build Workflow]

A docker container containing all needed **Linux** C/C++ build tools. Each
container will contain only one version of either **GCC** or **Clang** but will
contain all additional libraries and build tools needed (**Python 3**,
**Ninja**, etc). Currently we only support **64-bit** compilers.

## Usage

There are 2 ways to use this container [Interactive](#interactive) and
[Command](#command) mode.

### Interactive

This will drop you into an interactive `bash` session.

```bash
docker run -it -v /src:/src build-linux
```

### Command

This will run the supplied command directly.

```bash
docker run -it -v /src:/src build-linux [command]
```

## Building

```bash
docker build . -t build-linux \
    --build-arg COMPILER_PACKAGES='[clang*|gcc* g++*]' \
    --build-arg C_COMPILER_NAME='[clang*|gcc*]' \
    --build-arg CPP_COMPILER_NAME='[clang++*|g++*]' \
```

Currently only version `9` and `10` of both **GCC** and **Clang** are supported.

### Example

```bash
docker build . -t build-linux \
    --build-arg COMPILER_PACKAGES='gcc-10 g++10' \
    --build-arg C_COMPILER_NAME='gcc-10' \
    --build-arg CPP_COMPILER_NAME='g++-10' \
```

<!-- external links -->
[License]: https://img.shields.io/github/license/WNProject/DockerBuildLinux?label=License
[Build Badge]: https://github.com/WNProject/DockerBuildLinux/workflows/Build/badge.svg?branch=main
[Build Workflow]: https://github.com/WNProject/DockerBuildLinux/actions?query=workflow%3ABuild+branch%3Amain
