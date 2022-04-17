## Docker build system for plex-transcoder-placebo

This repository contains the build scripts for [plex-transcoder-placebo](https://github.com/bitnimble/plex-transcoder-placebo), a custom build of ffmpeg which contains both Plex's customisations as well as a backport of `libplacebo`. This allows for real-time shaders to be applied to any Plex video stream.

Building is done via Docker to keep things as standard as possible, since there are quite a few system oddities to get this building nicely, as Plex's version of ffmpeg seems to be statically linked against most dependencies and is compiled against musl instead of glibc (mostly).

## Current status - can I use it yet?

See [plex-transcoder-placebo's status](https://github.com/bitnimble/plex-transcoder-placebo/tree/anon/plex#status) instead (so I can just update it in one place).
