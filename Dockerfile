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
