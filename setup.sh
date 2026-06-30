#!/bin/bash
set -euo pipefail

echo "=== Fas 1: Sätter upp reproducerbar ARM64 cross-build-miljö ==="

cat <<'EOF' > Dockerfile.cross
FROM debian:bookworm-slim

RUN dpkg --add-architecture arm64 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        ninja-build \
        crossbuild-essential-arm64 \
        git \
        libasound2-dev:arm64 \
        libpulse-dev:arm64 && \
    rm -rf /var/lib/apt/lists/*

ENV ARCH=arm64
ENV TRIPLE=aarch64-linux-gnu
ENV CC=${TRIPLE}-gcc
ENV CXX=${TRIPLE}-g++

WORKDIR /workspace
EOF

docker build -t chromeos-arm64-builder -f Dockerfile.cross .

echo "=== Fas 2: Miljö redo! ==="
echo "Du kan nu cross-kompilera ditt projekt genom att köra:"
echo "docker run --rm -v \"$(pwd):/workspace\" chromeos-arm64-builder cmake -S . -B build -G Ninja"
