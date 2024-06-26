# FPGA IP Validation Benchmark

This project provides tools and Docker images for benchmarking FPGA IP validation processes, including bitstream generation and Design Rule Checks (DRC), both inside and outside of AWS Nitro Enclaves.

## Project Structure

- `verilog_sources/`: Contains FPGA designs and Docker setups for bitstream generation and DRC.
  - `benchmark/`: Scripts for comparing performance metrics.
  - `design1/`: Simple FPGA design with Docker setups for bitstream generation and DRC.
  - `design2/`: Second FPGA design with similar setup.
- `vivado-runtime/`: Docker setup for Xilinx Vivado 2023.2 runtime environment.

## Components

### Benchmark

Located in `verilog_sources/benchmark/`, this component provides tools to compare the performance of bitstream generation inside and outside a Trusted Execution Environment (TEE).

[View Benchmark README](verilog_sources/benchmark/README.md)

### Design1 and Design2

These directories contain FPGA designs along with Docker setups for bitstream generation and DRC. They can be run both in standard Docker environments and within AWS Nitro Enclaves for enhanced security.

[View Design1 README](verilog_sources/design1/README.md)

### Vivado Runtime

This component provides a Docker image for Xilinx Vivado 2023.2, enabling a consistent and portable environment for FPGA development.

[View Vivado Runtime README](vivado-runtime/README.md)

## Getting Started

1. Set up the Vivado runtime environment by following the instructions in the [Vivado Runtime README](vivado-runtime/README.md).
2. Build and run the Docker containers for bitstream generation and DRC as described in the [Design1 README](verilog_sources/design1/README.md).
3. Use the benchmark tools to compare performance metrics as explained in the [Benchmark README](verilog_sources/benchmark/README.md).

## Prerequisites

- Docker
- Docker Buildx
- AWS CLI v2 (for pushing to Amazon ECR and using AWS Nitro Enclaves)
- Python 3.6+ (for benchmark scripts)