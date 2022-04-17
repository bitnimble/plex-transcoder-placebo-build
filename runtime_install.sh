#!/bin/bash
# To be run on the Plex (runtime) box. This installs musl, etc, to satisfy some of the linking deps

PREFIX="/usr/local" THREADS=16 BUILD_DIR="/build"

install_deps() {
  apt update && apt install -y gcc git musl ninja-build python3 python3-pip python3-mako pkg-config unzip wget && \
  pip install meson && \
  mkdir -p /usr/lib/x86_64-linux/musl/ && \
  ln -s /usr/lib/x86_64-linux-musl/libc.so /usr/lib/x86_64-linux/musl/libc.musl-x86_64.so.1
}

install_deps

# Note: this may fail when trying to install the dependency `libnvidia-compute-495` due to an existing driver, but that's fine as it happens after the `libnvidia-encode.so` file is installed.
apt install -y --no-install-recommends libnvidia-encode-495
