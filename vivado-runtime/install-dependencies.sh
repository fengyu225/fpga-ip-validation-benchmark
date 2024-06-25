#!/bin/bash

# Update the package list
sudo apt-get update

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing Docker."
    sudo apt-get install -y docker.io

    # Start Docker service
    sudo systemctl start docker

    # Enable Docker to start at boot
    sudo systemctl enable docker

    # Add current user to the Docker group
    sudo usermod -aG docker $USER
else
    echo "Docker is already installed."
fi

# Create Docker CLI plugins directory
mkdir -p ~/.docker/cli-plugins/

# Download Docker Buildx plugin
curl -Lo ~/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.10.5/buildx-v0.10.5.linux-amd64

# Make Docker Buildx plugin executable
chmod +x ~/.docker/cli-plugins/docker-buildx

# Check if AWS CLI v2 is installed
if ! aws --version 2>&1 | grep -q "aws-cli/2"
then
    echo "AWS CLI v2 not found. Installing AWS CLI v2."

    # Remove AWS CLI v1 if installed
    sudo apt remove awscli -y

    # Install unzip
    sudo apt-get install unzip

    # Download AWS CLI v2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

    # Unzip the downloaded file
    unzip awscliv2.zip

    # Install AWS CLI v2
    sudo ./aws/install
else
    echo "AWS CLI v2 is already installed."
fi

# Verify the installation
aws --version