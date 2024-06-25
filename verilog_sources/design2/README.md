# Vivado Docker Image for Bitstream Generation and DRC

This repository provides a Docker image setup to either generate a bitstream or run Design Rule Checks (DRC) using Vivado. The specific task is controlled by passing a parameter to the Docker container.

## Prerequisites

- Docker installed on your system.
- Build the Vivado runtime base image using the `Dockerfile` in the `vivado-runtime` directory, or access to the base image `072422391281.dkr.ecr.us-east-1.amazonaws.com/vivado:v2023.2`.

## Files Overview

- `Dockerfile`: Defines the Docker image and its dependencies.
- `entrypoint.sh`: The entrypoint script that decides whether to run DRC or generate a bitstream based on the input parameter.
- `generate_bitstream.sh`: Script to generate a bitstream using Vivado in batch mode.
- `run_drc.sh`: Script to run DRC using Vivado in batch mode.

## Building the Docker Image

To build the Docker image, navigate to the directory containing the `Dockerfile` and run the following command:

```sh
docker build -t vivado_design2 .
```

This command will build the Docker image with the tag `vivado_design2`.

## Running the Docker Container

The Docker container can be run with different parameters to either generate a bitstream or run DRC.

### Generating a Bitstream

To generate a bitstream, run the Docker container with the `bitstream` parameter:

```sh
docker run --rm -v $(pwd):/home/ubuntu/verilog_sources/design2 vivado_design2:latest bitstream
```

This command will start the container and execute the `generate_bitstream.sh` script to generate the bitstream using Vivado.

### Running DRC

To run DRC, run the Docker container with the `drc` parameter:

```sh
docker run --rm -v $(pwd):/home/ubuntu/verilog_sources/design2 vivado_design2:latest drc
```

This command will start the container and execute the `run_drc.sh` script to run DRC using Vivado.

## Notes

- The necessary scripts and source files are copied into the Docker image during the build process.
- The `entrypoint.sh` script acts as the entry point of the container and validates the input parameter to determine which script to run.
- If an invalid parameter is passed, the container will exit with an error message.
- The `LD_PRELOAD` environment variable is set to `/lib/x86_64-linux-gnu/libudev.so.1` to ensure proper functionality of Vivado within the container.