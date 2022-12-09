#!/usr/bin/env bash

set -eux

layered_apps=(
  age
  akmod-nvidia
  fd-find
  fish
  fzf
  git-credential-libsecret
  gopass
  htop
  kitty
  moby-engine
  neovim
  nvidia-container-toolkit
  openconnect
  opensc
  p7zip
  python3-neovim
  ripgrep
  screen
  setroubleshoot-server
  sway
  tcpdump
  util-linux-user
  vulkan-tools
  wl-clipboard
  xorg-x11-drv-nvidia-cuda
  zsh
  qemu
  edk2-tools
  genisoimage
  spice-gtk-tools
  swtpm
  xrandr
)

flatpaks=(
  org.chromium.Chromium
  com.microsoft.Teams
  org.videolan.VLC
)

hostname="labtop"

add_kargs=(
# List kernel arguments to add to default kernel boot line here. Example:
#
# "console=tty0"
# "console=ttyS0,115200n8"
#
)

remove_kargs=(
#  List kernel arguments to add to default kernel boot line here. Example:
#
# "console=tty0"
#  "console=ttyS0,115200n8"
#
)

# add missing kernel args
add_kargs() {
    local kargs

    if [[ $# -ge 1 ]]; then
        kargs=$(rpm-ostree kargs)
        for arg
        do
            if [[ ! "$kargs" = *"$arg"* ]]; then
                printf "Appending karg %s ... " "$arg"
                rpm-ostree kargs --append-if-missing="$arg"
                printf "Done! \n"
            else
                printf "Not adding karg %s because it isn't present in karg string. \n" "$arg"
            fi
        done
    else
        printf "No kernel arguments to add! \n"
    fi
}

# remove kernel args
remove_kargs() {
    local kargs

    if [[ $# -ge 1 ]]; then
        kargs=$(rpm-ostree kargs)
        for arg
        do
            if [[ "$kargs" = *"$arg"* ]]; then
                printf "Removing karg %s ... " "$arg"
                rpm-ostree kargs --delete-if-present="$arg"
                printf "Done! \n"
            else
                printf "Not removing karg %s because it isn't present in karg string. \n" "$arg"
            fi
        done
    else
        printf "No kernel arguments to remove! \n"
    fi
}

# set hostnames
if [[ "$(hostnamectl hostname)" = "$hostname" ]]; then
    printf "System hostname correctly set! \n"
else
    printf "Setting system hostname... "
    hostnamectl hostname "$hostname"
    printf "Done! \n"
fi

# install layered apps
printf "Updating rpm-ostree and installing layered apps... \n"
rpm-ostree update

if [[ "${#layered_apps[@]}" -ge 1 ]]; then
    rpm-ostree install --idempotent --allow-inactive "${layered_apps[@]}"
fi

# configure flathub
printf "Configuring flathub for flatpak installations... \n"
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install flatpaks
printf "Installing flatpak apps... \n"

if [[ "${#flatpaks[@]}" -ge 1 ]]; then
    flatpak install --user "${flatpaks[@]}"
fi

# remove kernel arguments
remove_kargs "${remove_kargs[@]}"

# add kernel arguments
add_kargs "${add_kargs[@]}"
