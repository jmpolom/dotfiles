#!/bin/bash

set -eux

# Install RPM Fusion repositories
rpmfusion_free_url="https://mirrors.rpmfusion.org/free/fedora/\
rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"

rpmfusion_nonfree_url="https://mirrors.rpmfusion.org/nonfree/fedora/\
rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

rpmfusion_package_urls=()

if rpm --quiet -q rpmfusion-free-release; then
    printf "RPM Fusion free repository already configured! \n"
else
    printf "Adding RPM Fusion free repository... \n"
    rpmfusion_package_urls+=("${rpmfusion_free_url}")
fi

if rpm --quiet -q rpmfusion-nonfree-release; then
    printf "RPM Fusion nonfree repository already configured! \n"
else
    printf "Adding RPM Fusion nonfree repository... \n"
    rpmfusion_package_urls+=("${rpmfusion_nonfree_url}")
fi

if [[ "${#rpmfusion_package_urls[@]}" -ge 1 ]]; then
    printf "Installing RPM Fusion repositories... \n"
    rpm-ostree install --idempotent "${rpmfusion_package_urls[@]}"
fi
