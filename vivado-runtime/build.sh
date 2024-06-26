#!/bin/bash

# Check if builder instance named 'mybuilder' exists
if docker buildx inspect mybuilder > /dev/null 2>&1; then
  echo "Using existing builder instance 'mybuilder'"
  docker buildx use mybuilder
else
  echo "Creating new builder instance 'mybuilder'"
  docker buildx create --name mybuilder --use
fi

docker buildx inspect --bootstrap

# Specify the custom cache directory
CACHE_DIR="$HOME/.cache/docker-buildx"
mkdir -p "$CACHE_DIR"

# Build the Docker image and output it to the local Docker daemon
# Initialize the cache by running a dummy build step to populate the cache directory
docker buildx build --platform linux/amd64 -t vivado-runtime --cache-to=type=local,dest="$CACHE_DIR" --progress=plain --load .

# Perform the actual build using the initialized cache
docker buildx build --platform linux/amd64 -t vivado-runtime --output type=docker \
  --cache-from type=local,src="$CACHE_DIR" \
  --cache-to type=local,dest="$CACHE_DIR" .