#!/bin/bash

PREFIX="/usr/local" THREADS=16 BUILD_DIR="/build"

build_ffmpeg() {
  # DIR=/tmp/plex-transcoder && \
  # cd / && git clone git@github.com:bitnimble/plex-transcoder-placebo.git ${DIR} && \
  # cd ${DIR} && \
  DIR=/code && \
  cd ${DIR} && \
  PKG_CONFIG_PATH=${BUILD_DIR}/libass:${BUILD_DIR}/x264:${BUILD_DIR}/expat/expat:${BUILD_DIR}/libva/pkgconfig:${BUILD_DIR}/zlib:${BUILD_DIR}/fribidi:${BUILD_DIR}/freetype2/builds/unix:${BUILD_DIR}/harfbuzz/src:${BUILD_DIR}/fontconfig/fontconfig-2.13.94:${BUILD_DIR}/libpng/libpng-1.6.37:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/${BUILD_DIR}/nv-codec-headers:${BUILD_DIR}/libplacebo/build/meson-private:/usr/lib/x86_64-linux-gnu ./configure \
    --enable-static \
    --enable-shared \
    --disable-libx264 \
    --enable-ffnvcodec \
    --enable-nvenc \
    --disable-hwaccels \
    --disable-protocol=concat \
    --external-decoder=h264 \
    --enable-libglslang \
    --enable-vulkan \
    --enable-libplacebo \
    --enable-filter=libplacebo \
    --enable-debug \
    --enable-muxers \
    --fatal-warnings \
    --disable-gmp \
    --disable-avdevice \
    --disable-bzlib \
    --disable-sdl2 \
    --disable-decoders \
    --disable-devices \
    --disable-encoders \
    --disable-ffprobe \
    --disable-ffplay \
    --disable-doc \
    --disable-iconv \
    --disable-lzma \
    --disable-schannel \
    --disable-linux-perf \
    --disable-mediacodec \
    --disable-vaapi \
    --enable-eae \
    --disable-protocol='udp,udplite' \
    --arch=x86_64 \
    --target-os=linux \
    --strip=true \
    --cc=clang-11 \
    --cxx=clang++-11 \
    --pkg-config-flags=--static \
    --enable-cuda-llvm \
    --enable-cross-compile \
    --ar=llvm-ar \
    --nm=llvm-nm \
    --ranlib=llvm-ranlib \
    --extra-ldflags="-m64 -L${BUILD_DIR}/x264 -L${BUILD_DIR}/libva/va/.libs -L${BUILD_DIR}/libass/libass/.libs -L${BUILD_DIR}/fribidi/lib/.libs -L${BUILD_DIR}/harfbuzz/src/.libs -L${BUILD_DIR}/fontconfig/fontconfig-2.13.94/src/.libs -L${BUILD_DIR}/freetype2/objs/.libs -L${BUILD_DIR}/zlib -L${BUILD_DIR}/libpng/libpng-1.6.37/.libs -L${BUILD_DIR}/bzip2 -L${BUILD_DIR}/expat/expat/lib/.libs -L${BUILD_DIR}/libplacebo/build/src -L${BUILD_DIR}/libgcompat -L/usr/local/cuda/lib64 -L/usr/lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/pkgconfig -Wl,--gc-sections -Wl,-z,noexecstack -Wl,-z,relro -g2 -gdwarf-4 -Wl,--build-id=sha1 -flto=thin -fwhole-program-vtables -Wl,-O2 -Wl,-rpath,lib -l:libc.musl-x86_64.so.1 -l:libgcompat.so.0" \
    --extra-libs="${BUILD_DIR}/freetype2/objs/.libs/libfreetype.a" \
    --enable-decoder=png \
    --enable-decoder=apng \
    --enable-decoder=bmp \
    --enable-decoder=mjpeg \
    --enable-decoder=thp \
    --enable-decoder=gif \
    --enable-decoder=dirac \
    --enable-decoder=ffv1 \
    --enable-decoder=ffvhuff \
    --enable-decoder=huffyuv \
    --enable-decoder=rawvideo \
    --enable-decoder=zero12v \
    --enable-decoder=ayuv \
    --enable-decoder=r210 \
    --enable-decoder=v210 \
    --enable-decoder=v210x \
    --enable-decoder=v308 \
    --enable-decoder=v408 \
    --enable-decoder=v410 \
    --enable-decoder=y41p \
    --enable-decoder=yuv4 \
    --enable-decoder=ansi \
    --enable-decoder=alac \
    --enable-decoder=flac \
    --enable-decoder=vorbis \
    --enable-decoder=h264 \
    --enable-decoder=opus \
    --enable-decoder=pcm_f32be \
    --enable-decoder=pcm_f32le \
    --enable-decoder=pcm_f64be \
    --enable-decoder=pcm_f64le \
    --enable-decoder=pcm_lxf \
    --enable-decoder=pcm_s16be \
    --enable-decoder=pcm_s16be_planar \
    --enable-decoder=pcm_s16le \
    --enable-decoder=pcm_s16le_planar \
    --enable-decoder=pcm_s24be \
    --enable-decoder=pcm_s24le \
    --enable-decoder=pcm_s24le_planar \
    --enable-decoder=pcm_s32be \
    --enable-decoder=pcm_s32le \
    --enable-decoder=pcm_s32le_planar \
    --enable-decoder=pcm_s8 \
    --enable-decoder=pcm_s8_planar \
    --enable-decoder=pcm_u16be \
    --enable-decoder=pcm_u16le \
    --enable-decoder=pcm_u24be \
    --enable-decoder=pcm_u24le \
    --enable-decoder=pcm_u32be \
    --enable-decoder=pcm_u32le \
    --enable-decoder=pcm_u8 \
    --enable-decoder=pcm_alaw \
    --enable-decoder=pcm_mulaw \
    --enable-decoder=ass \
    --enable-decoder=dvbsub \
    --enable-decoder=ccaption \
    --enable-decoder=pgssub \
    --enable-decoder=jacosub \
    --enable-decoder=microdvd \
    --enable-decoder=movtext \
    --enable-decoder=mpl2 \
    --enable-decoder=pjs \
    --enable-decoder=realtext \
    --enable-decoder=sami \
    --enable-decoder=stl \
    --enable-decoder=subrip \
    --enable-decoder=subviewer \
    --enable-decoder=text \
    --enable-decoder=vplayer \
    --enable-decoder=webvtt \
    --enable-decoder=xsub \
    --enable-decoder=eac3_eae \
    --enable-decoder=truehd_eae \
    --enable-decoder=mlp_eae \
    --enable-encoder=flac \
    --enable-encoder=alac \
    --enable-encoder=mjpeg \
    --enable-encoder=wrapped_avframe \
    --enable-encoder=ass \
    --enable-encoder=dvbsub \
    --enable-encoder=dvdsub \
    --enable-encoder=movtext \
    --enable-encoder=ssa \
    --enable-encoder=subrip \
    --enable-encoder=text \
    --enable-encoder=webvtt \
    --enable-encoder=xsub \
    --enable-encoder=pcm_f32be \
    --enable-encoder=pcm_f32le \
    --enable-encoder=pcm_f64be \
    --enable-encoder=pcm_f64le \
    --enable-encoder=pcm_s8 \
    --enable-encoder=pcm_s8_planar \
    --enable-encoder=pcm_s16be \
    --enable-encoder=pcm_s16be_planar \
    --enable-encoder=pcm_s16le \
    --enable-encoder=pcm_s16le_planar \
    --enable-encoder=pcm_s24be \
    --enable-encoder=pcm_s24le \
    --enable-encoder=pcm_s24le_planar \
    --enable-encoder=pcm_s32be \
    --enable-encoder=pcm_s32le \
    --enable-encoder=pcm_s32le_planar \
    --enable-encoder=pcm_u8 \
    --enable-encoder=pcm_u16be \
    --enable-encoder=pcm_u16le \
    --enable-encoder=pcm_u24be \
    --enable-encoder=pcm_u24le \
    --enable-encoder=pcm_u32be \
    --enable-encoder=pcm_u32le \
    --enable-encoder=h264_nvenc \
    --enable-encoder=eac3_eae \
    --enable-libass \
    --prefix=/usr \
    --extra-cflags="-m64 -static -O3 -fdata-sections -ffunction-sections -fno-omit-frame-pointer -g2 -gdwarf-4 -fcommon -flto=thin -fwhole-program-vtables -I${BUILD_DIR}/x264 -I${BUILD_DIR}/libass -I${BUILD_DIR}/nv-codec-headers/include/ffnvcodec -I${BUILD_DIR}/libplacebo/src/include -I${BUILD_DIR}/libplacebo/build/src/include -I/usr/include -I${BUILD_DIR}/zlib -I/usr/local/cuda/include -I/usr/include/vulkan -DLIBXML_STATIC -DNDEBUG" && \
  sed -i 's/HAVE_SYSCTL 1/HAVE_SYSCTL 0/g' config.h && \
  ffbuild/version.sh $(pwd) libavutil/ffversion.h && \
  sed -i "s/N-105289-g2b053cf9a9/62cc2bc-4278/g" libavutil/ffversion.h && \
  make -j${threads} V=s > build.log && \
  cp -t /build ffmpeg_g libavformat/libavformat.so.58 libavutil/libavutil.so.56 libswscale/libswscale.so.5 libswresample/libswresample.so.3
}

build_ffmpeg
