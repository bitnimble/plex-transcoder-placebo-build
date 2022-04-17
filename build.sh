DOCKER_BUILDKIT=1 docker build . -o target | tee log.txt
chmod 755 target
