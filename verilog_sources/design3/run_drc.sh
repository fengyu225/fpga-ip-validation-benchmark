#!/bin/bash

# Run DRC
LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 vivado -mode batch -source /home/ubuntu/verilog_sources/design3/run_drc.tcl