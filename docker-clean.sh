#!/bin/bash

while true; do
  # Remove exited containers
  docker rm -v $(docker ps -a -q -f status=exited)
  # Remove dangling images
  docker rmi $(docker images -f "dangling=true" -q)
  # Remove dangling volumes
  docker volume rm $(docker volume ls -qf dangling=true)

  # DOCKER_CLEAN_INTERVAL defaults to 30min
  sleep $DOCKER_CLEAN_INTERVAL
done
