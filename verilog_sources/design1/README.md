# Vivado Docker Image for Bitstream Generation and DRC

This repository provides a Docker image setup to either generate a bitstream or run Design Rule Checks (DRC) using Vivado. The specific task is controlled by passing a parameter to the Docker container.

## Prerequisites

- Docker installed on your system.
- Build the Vivado runtime base image using the `Dockerfile` in the `vivado-runtime` directory, or have access to the base image `072422391281.dkr.ecr.us-east-1.amazonaws.com/vivado:v2023.2`.

## Files Overview

- `Dockerfile`: Defines the Docker image.
- `entrypoint.sh`: The entrypoint script that decides whether to run DRC or generate a bitstream based on the input parameter.
- `generate_bitstream.sh`: Script to generate a bitstream.
- `run_drc.sh`: Script to run DRC.

## Building the Docker Image

To build the Docker image, navigate to the directory containing the `Dockerfile` and run the following command:

```sh
docker build -t vivado_design1:latest .
```

## Running the Docker Container

### Generating a Bitstream

To generate a bitstream, run the Docker container with the `bitstream` parameter:

```sh
docker run --rm -v $(pwd):/home/ubuntu/verilog_sources/design1 vivado_design1:latest bitstream
```

### Running DRC

To run DRC, run the Docker container with the `drc` parameter:

```sh
docker run --rm -v $(pwd):/home/ubuntu/verilog_sources/design1 vivado_design1:latest drc
```

## Notes

- Ensure that the necessary scripts and source files are copied correctly into the Docker image as specified in the `Dockerfile`.
- The `entrypoint.sh` script will validate the input parameter and execute the corresponding script.
- If an invalid parameter is passed, the container will exit with an error message.
- The `LD_PRELOAD` environment variable is set to `/lib/x86_64-linux-gnu/libudev.so.1` to ensure proper functionality of Vivado within the container.
