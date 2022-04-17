# syntax=docker/dockerfile:1.2

FROM alpine:latest AS musl-build
COPY build_musl_dependencies.sh /tmp/build.sh
RUN mkdir /build
RUN /tmp/build.sh

FROM debian:latest AS glibc-build
COPY build_glibc.sh /tmp/build.sh
COPY --from=musl-build /build /build
RUN /tmp/build.sh

FROM glibc-build AS ffmpeg-build
COPY build_ffmpeg.sh /tmp/build.sh
COPY plex-transcoder-placebo /code
RUN /tmp/build.sh || true

FROM scratch
COPY --from=ffmpeg-build /code/ffmpeg_g /code/libavformat/libavformat.so.58 /code/libavutil/libavutil.so.56 /code/libswscale/libswscale.so.5 /code/libswresample/libswresample.so.3 /build/libgcompat/libgcompat.so.0 /build/libplacebo/build/src/libplacebo.so.202 /code/ffbuild/config.log /code/build.log /
COPY --from=ffmpeg-build /code/ffbuild/config.log /code/build.log /
