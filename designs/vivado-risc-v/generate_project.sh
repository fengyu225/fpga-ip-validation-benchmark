#!/bin/bash

# Exit on any error, undefined variable, or pipe failure
set -euo pipefail

# Function to log messages
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to handle errors
handle_error() {
    log "Error occurred on line $1"
    exit 1
}

# Set up error handling
trap 'handle_error $LINENO' ERR

# Change to the vivado-risc-v directory
log "Changing to /vivado-risc-v directory"
cd /vivado-risc-v

# Install Vivado board files
rsync -avHP /vivado-boards/new/board_files/ /opt/Xilinx/Vivado/2023.2/data/boards/board_files/

# Modify Makefile to add -y to apt install commands
log "Modifying Makefile to ensure non-interactive apt install"
sed -i 's/apt install/apt install -y/g' Makefile

# Install tzdata non-interactively
log "Installing tzdata"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tzdata
echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections
echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections

# Run apt-install
log "Running make apt-install"
DEBIAN_FRONTEND=noninteractive make apt-install

# Update submodules
log "Updating submodules"
make update-submodules

# Ensure CONFIG and BOARD are set
if [ -z "${CONFIG:-}" ] || [ -z "${BOARD:-}" ]; then
    log "ERROR: Please set CONFIG and BOARD environment variables"
    exit 1
fi

# Generate system device tree
log "Generating system device tree"
make workspace/$CONFIG/system.dts

# Generate board-specific device tree and FIRRTL
log "Generating board-specific device tree and FIRRTL"
make workspace/$CONFIG/system-$BOARD/RocketSystem.fir

# Generate Verilog for Rocket SoC
log "Generating Verilog for Rocket SoC"
make workspace/$CONFIG/system-$BOARD.v

# Generate VHDL wrapper
log "Generating VHDL wrapper"
make workspace/$CONFIG/rocket.vhdl

# Create Vivado Tcl script
log "Creating Vivado Tcl script"
make workspace/$CONFIG/system-$BOARD.tcl

# Generate Vivado project
log "Generating Vivado project"
make vivado-project