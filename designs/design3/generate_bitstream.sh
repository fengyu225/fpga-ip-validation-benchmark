#!/bin/bash

LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 vivado -mode batch -source /home/ubuntu/designs/design3/generate_bitstream.tcl
