# Vivado Runtime Docker Image

This project provides a Docker image for Xilinx Vivado 2023.2, enabling a consistent and portable environment for FPGA development.

## Prerequisites

- Docker
- Docker Buildx
- AWS CLI v2 (for pushing to Amazon ECR)

## Setup

1. Install dependencies:

   ```bash
   ./install-dependencies.sh
   ```

This script installs Docker, Docker Buildx, and AWS CLI v2 if they're not already present on your system.

2. Prepare the Vivado installer:
    - Place the Vivado installer `FPGAs_AdaptiveSoCs_Unified_2023.2_1013_2256_Lin64.bin` in the same directory as the Dockerfile.
    - Create a `password.txt` file containing your Xilinx account password, put username in the first line and password in the second line.
    - Ensure `generate_token.expect` and `install_configs.txt` are present in the directory.

## Building the Image

To build the Vivado runtime image:

```bash
./build.sh
```

This script:
- Creates or uses an existing Docker buildx instance named 'mybuilder'.
- Uses a local cache to speed up subsequent builds.
- Builds the image for the linux/amd64 platform.

## Image Details

The Dockerfile:
- Uses Ubuntu 20.04 as the base image.
- Installs necessary dependencies.
- Extracts and installs Vivado 2023.2 using the provided installer and configuration.
- Sets up the required environment variables for Vivado.

## Pushing to Amazon ECR

To push the built image to Amazon ECR:

```bash
./push.sh
```

This script:
- Logs in to Amazon ECR.
- Tags the local image for the ECR repository.
- Pushes the image to ECR.

## Usage

After building, you can run the Vivado runtime image using:

```bash
docker run -it vivado-runtime:latest
```

This will start a bash session in the container with Vivado 2023.2 available.

## Note

Ensure you have the necessary permissions and have configured AWS CLI correctly before pushing to ECR.