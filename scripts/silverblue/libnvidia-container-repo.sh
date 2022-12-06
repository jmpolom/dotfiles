#!/usr/bin/env bash

set -eux

repofile="libnvidia-container.repo"

if [[ ! -f /etc/yum.repos.d/${repofile} ]]; then
    curl -sSL https://nvidia.github.io/libnvidia-container/centos8/${repofile} | sudo tee /etc/yum.repos.d/${repofile}
else
    echo "libnvidia-container repo appears present, taking no action."
fi
