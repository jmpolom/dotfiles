#!/usr/bin/env bash

set -eux

if [[ ! -f /etc/yum.repos.d/libnvidia-container.repo ]]; then
    curl -sSL https://nvidia.github.io/libnvidia-container/centos8/libnvidia-container.repo | sudo tee /etc/yum.repos.d/libnvidia-container.repo
else
    echo "libnvidia-container repo appears present, taking no action."
fi
