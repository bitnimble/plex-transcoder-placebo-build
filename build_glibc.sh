#!/bin/bash

PREFIX="/usr/local" THREADS=16 BUILD_DIR="/build"

install_deps() {
  # TODO: change apt source to `sid`
  apt update && apt install -y software-properties-common gnupg curl clang git glslang-dev llvm meson musl ninja-build nasm python3 python3-pip python3-mako yasm pkg-config && \
  echo "deb http://deb.debian.org/debian sid main" >> /etc/apt/sources.list &&
  apt update && apt install -y --no-install-recommends libvulkan-dev && \
  sed -i '$d' /etc/apt/sources.list && \
  ln -s /lib/x86_64-linux-musl/libc.so /usr/lib/libc.musl-x86_64.so.1
}

install_ffnvcodec() {
  DIR=${BUILD_DIR}/nv-codec-headers && \
	git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git ${DIR} && \
	cd ${DIR} && \
	make PREFIX="${PREFIX}" && \
  make install
}

# cuda 10 gets us support for drivers / devices going back to Sep 2018
install_cuda_toolkit() {
  apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/7fa2af80.pub
  add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /"
  add-apt-repository contrib
  apt update
  apt install -y cuda-toolkit-10-0
}

install_libplacebo() {
  DIR=${BUILD_DIR}/libplacebo && \
  git clone https://code.videolan.org/videolan/libplacebo ${DIR} && \
  cd ${DIR} && \
  meson ./build && \
  ninja -C./build
}

install_deps
install_ffnvcodec
install_cuda_toolkit
install_libplacebo
