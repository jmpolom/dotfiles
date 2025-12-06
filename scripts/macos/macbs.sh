#!/bin/zsh

set -eux

vared -p "Enter desired system hostname: " -c hostname

# set hostnames
if [[ -v hostname ]]; then
  if [[ "$(scutil --get ComputerName)" = "$hostname" ]] && \
     [[ "$(scutil --get HostName)" = "$hostname" ]]; then
      printf "macOS HostName and ComputerName are correctly set! \n"
  else
      printf "Setting macOS HostName and ComputerName... "
      scutil --set ComputerName "$hostname"
      scutil --set HostName "$hostname"
      printf "Done! \n"
  fi
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

# make sure git is initially installed
if ! command -v git &> /dev/null; then
    printf "Installing git via xcode tools... \n"
    xcode-select --install
    printf "Done! \n"
else
    printf "Looks like git is already installed! \n"
fi

# install brew
if ! command -v /opt/homebrew/bin/brew &> /dev/null; then
    printf "Installing homebrew... \n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&
    printf "Done! \n"
else
    printf "Looks like homebrew is already installed! \n"
fi
