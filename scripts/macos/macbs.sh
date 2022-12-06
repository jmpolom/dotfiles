#!/bin/zsh

set -eux

# add /opt/homebrew/bin to path in case it isn't present
export PATH=/opt/homebrew/bin:$PATH

brew_apps=(
    coreutils
    curl
    fd
    fzf
    git
    git-lfs
    gnupg
    htop
    libvirt
    lima
    magic-wormhole
    minicom
    multimarkdown
    neovim
    pinentry-mac
    pass
    readline
    ripgrep
    screen
    shellcheck
    shellharden
    shfmt
    wireguard-go
    wireguard-tools
    ykman
    youtube-dl
    xz
)

brew_casks=(
  1password
  adguard
  chromium
  firefox
  iterm2
  jitsi-meet
  logitech-options
  microsoft-edge
  microsoft-teams
  mumble
  mullvadvpn
  rectangle
  signal
  spotify
  visual-studio-code-insiders
  vlc
)

hostname="satellite"

# install python versions with pyenv
install_pyenv () {
    if ! command -v pyenv 1>/dev/null 2>&1; then
        python2="2.7.18"
        python3="3.10.2"

        printf "Installing pyenv python2 (%s) and python3 (%s)... \n" "$python2" "$python3"

        pyenv install -s "$python2"
        pyenv install -s "$python3"

        # setup global python versions
        printf "Setting global python versions with pyenv... \n"
        pyenv global "$python2" "$python3"

        # install ansible and neovim packages
        printf "Installing global python packages... \n"
        PIP_REQUIRE_VIRTUALENV=false pip3 install --upgrade ansible black jedi pynvim
    else
        printf "Looks like pyenv already exists! \n"
    fi
}

# set hostnames
if [[ "$(scutil --get ComputerName)" = "$hostname" ]] && \
   [[ "$(scutil --get HostName)" = "$hostname" ]]; then
    printf "macOS HostName and ComputerName are correctly set! \n"
else
    printf "Setting macOS HostName and ComputerName... "
    scutil --set ComputerName "$hostname"
    scutil --set HostName "$hostname"
    printf "Done! \n"
fi

# disable power chime
if [[ "$(defaults read com.apple.PowerChime ChimeOnNoHardware)" -eq 0 ]]; then
    printf "Disabling power chime because nobody likes that obnoxious shit... "
    defaults write com.apple.PowerChime ChimeOnNoHardware -bool true
        if [[ -n "$(pgrep PowerChime)" ]]; then
            killall PowerChime
        fi
    printf "Done! \n"
else
    printf "Looks like PowerChime is already disabled! \n"
fi

## make sure git is initially installed
#if ! command -v git &> /dev/null; then
#    printf "Installing git via xcode tools... \n"
#    xcode-select --install
#    printf "Done! \n"
#else
#    printf "Looks like git is already installed! \n"
#fi
#
## check if macports installed
#if ! command -v ports &> /dev/null; then
#    printf "macports not installed, please install! \n"
#    exit 1
#fi
#
## install packages from macports
#printf "Updating macports and installing packages... \n"
#sudo port selfupdate
#for package in ${macports[@]}
#do
#    sudo port install "${package}"
#done
#printf "Done! \n"

# install brew
if ! command -v /opt/homebrew/bin/brew &> /dev/null; then
    printf "Installing homebrew... \n"
    /bin/bash -c homebrew-install/install.sh &&
    printf "Done! \n"
else
    printf "Looks like homebrew is already installed! \n"
fi

# install packages from homebrew core
printf "Updating brew, upgrading installed packages and installing apps... \n"
/opt/homebrew/bin/brew update
/opt/homebrew/bin/brew upgrade
/opt/homebrew/bin/brew install "${brew_apps[@]}"

# tap additional casks
printf "Tapping additional casks... \n"
/opt/homebrew/bin/brew tap homebrew/homebrew-cask-drivers
/opt/homebrew/bin/brew tap homebrew/homebrew-cask-versions
/opt/homebrew/bin/brew tap homebrew/homebrew-cask-fonts

# Install fonts
printf "Installing fonts... \n"
/opt/homebrew/bin/brew install font-meslo-for-powerline \
                               font-meslo-lg \
                               font-meslo-lg-dz \
                               font-meslo-lg-nerd-font

printf "Installing homebrew casks... \n"
/opt/homebrew/bin/brew install --cask "${brew_casks[@]}"
