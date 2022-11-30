#!/bin/zsh

# create ssh config directory if it is missing
if [[ ! -d "$HOME/.ssh" ]] && hash ssh 2>/dev/null; then
    printf "Creating ~/.ssh directory since it is missing... "
    mkdir -p "$HOME/.ssh"
    printf "done! \n"
fi

# link ssh configs
if [[ ! -e "$HOME/.ssh/config" ]]; then
    printf "Linking ssh config... "
    UNAME=$(uname)
    if [[ "$UNAME" == "Darwin" ]]; then
        ln -sf "$(realpath config.mac)" "$HOME/.ssh/config"
        printf "config.mac linked to ~/.ssh/config\n"
    elif [[ "$UNAME" == "Linux" ]]; then
        ln -sf "$(realpath config.linux)" "$HOME/.ssh/config"
        printf "config.linux linked to ~/.ssh/config\n"
    fi
fi
