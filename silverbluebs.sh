#!/bin/bash

layered_apps=(
  1password
  fd-find
  fzf
  git-credential-libsecret
  htop
  meslo-lg-fonts
  neovim
  p7zip
  python3-neovim
  radeontop
  ripgrep
  screen
  solaar
  sway
  tcpdump
  util-linux-user
  vulkan-tools
  wl-clipboard
  zsh
)

flatpaks=(
  org.chromium.Chromium
  org.jitsi.jitsi-meet
  com.mattermost.Desktop
  info.mumble.Mumble
  org.signal.Signal
  com.spotify.Client
  com.microsoft.Teams
  us.zoom.Zoom
)

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
    local KARGS

    if [[ $# -ge 1 ]]; then
        KARGS=$(rpm-ostree kargs)
        for arg
        do
            if [[ ! "$KARGS" = *"$arg"* ]]; then
                printf "Appending karg %s ... " "$arg"
                rpm-ostree kargs --append-if-missing="$arg"
                printf "done! \n"
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
    local KARGS

    if [[ $# -ge 1 ]]; then
        KARGS=$(rpm-ostree kargs)
        for arg
        do
            if [[ "$KARGS" = *"$arg"* ]]; then
                printf "Removing karg %s ... " "$arg"
                rpm-ostree kargs --delete-if-present="$arg"
                printf "done! \n"
            else
                printf "Not removing karg %s because it isn't present in karg string. \n" "$arg"
            fi
        done
    else
        printf "No kernel arguments to remove! \n"
    fi
}

# install layered apps
printf "Updating rpm-ostree and installing layered apps... \n"
rpm-ostree update
rpm-ostree install --idempotent "${layered_apps[@]}"

# configure flathub
printf "Configuring flathub for flatpak installations... "
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
printf "done! \n"

# install flatpaks
printf "Installing flatpak apps... "
flatpak install "${flatpaks[@]}"
printf "Flatpaks installed! \n"

# remove kernel arguments
remove_kargs "${remove_kargs[@]}"

# add kernel arguments
add_kargs "${add_kargs[@]}"
