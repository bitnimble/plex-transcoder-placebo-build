#!/bin/sh

# TODO: replace git dependencies with versioned wget's
# TODO: combine all build files into a single Dockerfile

PREFIX="/usr/local"
PKG_CONFIG="pkg-config --static"
THREADS=16
BUILD_DIR="/build"

# Build tooling dependencies
build_deps="\
  autoconf \
  automake \
  bash \
  bison \
  binutils \
  bzip2 \
  ca-certificates \
  clang \
  cmake \
  curl \
  coreutils \
  file \
  gcc \
  g++ \
  groff \
  gperf \
  git \
  libtool \
  libx11-dev \
  libxcursor-dev \
  libxi-dev \
  libxinerama-dev \
  libxrandr-dev \
  llvm \
  make \
  mesa-dev \
  meson \
  musl-dev \
  nasm \
  ninja \
  openssl-dev \
  patch \
  python3 \
  subversion \
  tar \
  texinfo \
  xz \
  yasm \
  zlib-dev \
" && apk add ${build_deps}

ln -s /usr/lib/llvm12/lib/LLVMgold.so /usr/lib/LLVMgold.so
ln -s /usr/bin/python3 /usr/bin/python

# Shared libs
build_libs="\
  opus-dev \
  libvorbis-dev \
  libunistring-dev \
  rtmpdump-dev \
  lame-dev \
  intel-media-driver-dev \
  libogg-dev \
  opencl-icd-loader-dev \
  opencl-headers \
  nettle-dev \
  libidn-dev \
  libdrm-dev \
  libxml2-dev \
  gnutls-dev \
  gnu-libiconv-dev \
  util-linux-dev \
  libpciaccess-dev \
" && apk add ${build_libs}

install_freepascal() {
  DIR=${BUILD_DIR}/fpc && \
  mkdir ${DIR} && cd ${DIR} && \
  curl -sL ftp://mirror.freemirror.org/pub/fpc/dist/3.2.2/x86_64-linux/fpc-3.2.2.x86_64-linux.tar | tar -xv && \
  cd fpc-3.2.2.x86_64-linux && \
  echo -e '/usr\nN\nN\nN\n' | sh ./install.sh
}

install_gettext() {
  DIR=${BUILD_DIR}/gettext && \
  git clone https://git.savannah.gnu.org/git/gettext.git ${DIR} && \
  cd ${DIR} && \
  git clone https://git.savannah.gnu.org/git/gnulib.git && \
  ./autogen.sh && \
  ./configure --enable-static && \
  cd gettext-runtime && \
  make -j${THREADS}
}

install_ffnvcodec() {
	DIR=${BUILD_DIR}/nv-codec-headers && \
	git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git ${DIR} && \
	cd ${DIR} && \
	make PREFIX="${PREFIX}"
}

install_libgcompat() {
  DIR=${BUILD_DIR}/libgcompat && \
  git clone https://github.com/Stantheman/gcompat ${DIR} && \
  cd ${DIR} && \
  make -j${THREADS} CC=clang LINKER_PATH=/lib/ld-musl-x86_64.so.1 LOADER_NAME=ld-linux.so.2 && \
  make install DESTDIR=${PREFIX} LINKER_PATH=/lib/ld-musl-x86_64.so.1 LOADER_NAME=ld-linux.so.2
}

install_libva() {
  DIR=${BUILD_DIR}/libva && \
  git clone https://github.com/intel/libAva ${DIR} && \
  cd ${DIR} && \
  ./autogen.sh && \
  ./configure --enable-static=yes && \
  make -j${THREADS} && \
  rm -rf ${BUILD_DIR}/libva/va/.libs/libva.so* ${BUILD_DIR}/libva/va/.libs/libva-drm.so*
}

install_zlib() {
  DIR=${BUILD_DIR}/zlib && \
  git clone https://github.com/madler/zlib ${DIR} && \
  cd ${DIR} && \
  CFLAGS="-fPIC -static"  ./configure --static && \
  make -j${THREADS}
}

install_harfbuzz() {
  DIR=${BUILD_DIR}/harfbuzz && \
  git clone https://github.com/harfbuzz/harfbuzz ${DIR} && \
  cd ${DIR} && \
  ./autogen.sh && \
  CFLAGS="-fPIC -static" ./configure --enable-static && \
  make -j${THREADS}
}

install_freetype2() {
  DIR=${BUILD_DIR}/freetype2 && \
  git clone https://github.com/freetype/freetype ${DIR} && \
  cd ${DIR} && \
  ./autogen.sh && \
  CFLAGS="-fPIC -static"  ./configure --enable-static && \
  make -j${THREADS}
}

install_expat() {
  DIR=${BUILD_DIR}/expat && \
  git clone https://github.com/libexpat/libexpat ${DIR} && \
  cd ${DIR}/expat && \
  ./buildconf.sh && \
  CFLAGS="-fPIC -static"  ./configure --enable-static && \
  make -j${THREADS}
}

install_fontconfig() {
  DIR=${BUILD_DIR}/fontconfig && \
  mkdir ${DIR} && cd ${DIR} && \
  curl -sL https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.94.tar.gz | tar -xz && \
  cd fontconfig-2.13.94 && \
  PKG_CONFIG_PATH=${BUILD_DIR}/freetype2/builds/unix:${BUILD_DIR}/expat/expat CFLAGS="-fPIC -static -I${BUILD_DIR}/freetype2/include -I${BUILD_DIR}/expat/expat/lib" LDFLAGS="-L${BUILD_DIR}/freetype2/objs -L${BUILD_DIR}/expat/expat/lib/.libs" ./configure --enable-static --with-libintl-prefix=/usr && \
  cd src && make -j${THREADS}
}

install_fribidi() {
  DIR=${BUILD_DIR}/fribidi && \
  git clone https://github.com/fribidi/fribidi ${DIR} && \
  cd ${DIR} && \
  ./autogen.sh && \
  CFLAGS="-fPIC -static" ./configure --enable-static && \
  make -j${THREADS}
}

install_libass() {
  DIR=${BUILD_DIR}/libass && \
  git clone https://github.com/libass/libass ${DIR} && \
  cd ${DIR} && \
  ./autogen.sh && \
  PKG_CONFIG_PATH=${BUILD_DIR}/fribidi:${BUILD_DIR}/freetype2/builds/unix:${BUILD_DIR}/harfbuzz/src:${BUILD_DIR}/expat/expat:${BUILD_DIR}/fontconfig/fontconfig-2.13.94 CFLAGS="-fPIC -static -I${BUILD_DIR}/freetype2/include -I${BUILD_DIR}/harfbuzz/src -I${BUILD_DIR}/fribidi/lib -I${BUILD_DIR}/fontconfig/fontconfig-2.13.94" LDFLAGS="-L${BUILD_DIR}/fribidi/lib/.libs -L${BUILD_DIR}/harfbuzz/src/.libs -L${BUILD_DIR}/fontconfig/fontconfig-2.13.94/src/.libs -L${BUILD_DIR}/freetype2/objs" ./configure --enable-static && \
  make -j${THREADS} && \
  ln -s ${BUILD_DIR}/libass/libass ${BUILD_DIR}/libass/ass
}

install_libpng() {
  DIR=${BUILD_DIR}/libpng && \
  mkdir ${DIR} && cd ${DIR} && \
  curl -sL https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz | tar -xz && \
  cd libpng-1.6.37 && \
  LDFLAGS="-L${BUILD_DIR}/zlib" CFLAGS="-fPIC -static" ./configure --enable-static && \
  make -j${THREADS}
}

install_bzip() {
  DIR=${BUILD_DIR}/bzip2 && \
  git clone git://sourceware.org/git/bzip2.git ${DIR} && \
  cd ${DIR} && make -j${threads}
}

install_freepascal
install_gettext
install_ffnvcodec
install_libgcompat
install_libva
install_zlib
install_harfbuzz
install_freetype2
install_expat
install_fontconfig
install_fribidi
install_libass
install_libpng
install_bzip
