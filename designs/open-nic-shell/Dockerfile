# Stage 1: Base setup and Vivado installation
FROM --platform=linux/amd64 ubuntu:20.04 AS base

# Preconfigure environment to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    xz-utils \
    tar \
    libtinfo5 \
    libncurses5 \
    libx11-6 \
    libxrender1 \
    libxft2 \
    libxtst6 \
    locales \
    expect \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a directory for the installer
RUN mkdir -p /opt/Xilinx

# Copy the installer and expect script into the image
COPY ./FPGAs_AdaptiveSoCs_Unified_2023.2_1013_2256_Lin64.bin /opt/Xilinx/
COPY generate_token.expect /opt/Xilinx/

# Set working directory
WORKDIR /opt/Xilinx

# Make the installer and script executable
RUN chmod +x FPGAs_AdaptiveSoCs_Unified_2023.2_1013_2256_Lin64.bin
RUN chmod +x generate_token.expect

# Extract the installer
RUN ./FPGAs_AdaptiveSoCs_Unified_2023.2_1013_2256_Lin64.bin --noexec --target /opt/Xilinx/installer

# Copy secret password file
COPY password.txt /opt/Xilinx/password.txt

# Copy the install config file
COPY install_configs.txt /opt/Xilinx/install_configs.txt

# Generate the authentication token using expect script
RUN expect generate_token.expect /opt/Xilinx/password.txt

# Install Vivado
RUN /opt/Xilinx/installer/xsetup --agree XilinxEULA,3rdPartyEULA --location /opt/Xilinx --batch Install -c /opt/Xilinx/install_configs.txt

# Clone Xilinx Board Store repository
RUN git clone https://github.com/Xilinx/XilinxBoardStore.git /board_store

# Clone OpenNIC shell repository
RUN git clone https://github.com/Xilinx/open-nic-shell.git /open-nic-shell

# Stage 2: Final image setup
FROM ubuntu:20.04

# Set environment variables for Vivado
ENV PATH="/opt/Xilinx/Vivado/2023.2/bin:$PATH"
ENV LD_PRELOAD='/lib/x86_64-linux-gnu/libudev.so.1'

# Copy only the necessary files from the base stage
COPY --from=base /opt/Xilinx/Vivado /opt/Xilinx/Vivado
COPY --from=base /board_store /board_store
COPY --from=base /open-nic-shell /open-nic-shell

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install necessary packages for building
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    xz-utils \
    tar \
    libtinfo5 \
    libncurses5 \
    libx11-6 \
    libxrender1 \
    libxft2 \
    libxtst6 \
    locales \
    expect \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Copy necessary scripts and source files into the Docker image
COPY generate_bitstream.sh /open-nic-shell/generate_bitstream.sh

# Set working directory
WORKDIR /open-nic-shell/script

# Set the default command to run the bitstream generation script
CMD ["/open-nic-shell/generate_bitstream.sh"]