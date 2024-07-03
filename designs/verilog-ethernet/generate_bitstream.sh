#!/bin/bash

# Set necessary environment variables
export LANGUAGE=en_US:en
export TZ=Etc/UTC
export LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1
export HOME=/root
export LANG=en_US.UTF-8
export LD_LIBRARY_PATH=/opt/Xilinx/Vivado/2023.2/lib/lnx64.o:
export LC_ALL=en_US.UTF-8
export PATH=/opt/Xilinx/Vivado/2023.2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Print the current working directory and list its contents
echo "Current working directory is: $(pwd)"

pushd /verilog-ethernet/example/NexysVideo/fpga || exit

echo "Generating bitstream..."

make