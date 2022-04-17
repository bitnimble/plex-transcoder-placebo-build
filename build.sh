DOCKER_BUILDKIT=1 docker build . --build-arg CACHEBUST=$(date +%s) | tee log.txt
chmod 755 target
