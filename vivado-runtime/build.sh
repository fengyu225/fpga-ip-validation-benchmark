# Create and use a new builder instance
docker buildx create --name mybuilder --use
docker buildx inspect --bootstrap

# Specify the custom cache directory
CACHE_DIR="$HOME/.cache/docker-buildx"
mkdir -p "$CACHE_DIR"

# Build the Docker image and output it to the local Docker daemon
docker buildx build --platform linux/amd64 -t vivado-runtime --output type=docker \
  --cache-from type=local,src="$CACHE_DIR" \
  --cache-to type=local,dest="$CACHE_DIR" .