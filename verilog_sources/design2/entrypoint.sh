#!/bin/bash

# Check the parameter passed to the container
if [ "$1" == "drc" ]; then
    echo "Running DRC..."
    ./run_drc.sh
elif [ "$1" == "bitstream" ]; then
    echo "Generating Bitstream..."
    ./generate_bitstream.sh
else
    echo "Invalid parameter. Use 'drc' to run DRC or 'bitstream' to generate a bitstream."
    exit 1
fi