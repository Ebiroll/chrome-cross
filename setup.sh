#!/bin/bash

# Install required packages
sudo apt-get update
sudo apt-get install -y cmake ninja-build


# Set up cross-compilation environment variables
echo 'export CROSS_COMPILE=aarch64-linux-gnu-' >> ~/.bashrc
echo 'export CC=${CROSS_COMPILE}gcc' >> ~/.bashrc
echo 'export CXX=${CROSS_COMPILE}g++' >> ~/.bashrc

git clone https://chromium.googlesource.com/chromiumos/chromite

export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=arm64
source chromite/bin/cros_sdk
cros_sdk

