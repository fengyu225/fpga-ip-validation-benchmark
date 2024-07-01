# Use an Ubuntu base image with x86_64 architecture
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
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a directory for the installer
RUN mkdir -p /opt/Xilinx

# Copy the installer and expect script into the image
COPY ../FPGAs_AdaptiveSoCs_Unified_2023.2_1013_2256_Lin64.bin /opt/Xilinx/
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

# Run the installation using the authentication token
RUN /opt/Xilinx/installer/xsetup --agree XilinxEULA,3rdPartyEULA --location /opt/Xilinx -c /opt/Xilinx/install_configs.txt --batch Install

# Create a new stage for the final image
FROM ubuntu:20.04

# Set environment variables for Vivado
ENV PATH="/opt/Xilinx/Vivado/2023.2/bin:$PATH"
ENV LD_LIBRARY_PATH='/opt/Xilinx/Vivado/2023.2/lib/lnx64.o:$LD_LIBRARY_PATH'

# Copy only the necessary files from the base stage
COPY --from=base /opt/Xilinx/Vivado /opt/Xilinx/Vivado

# Default command
CMD ["bash"]