#!/bin/zsh

# add /opt/homebrew/bin to path in case it isn't present
export PATH=/opt/homebrew/bin:$PATH

# link neovim config
if [[ ! -d "$HOME/.config/nvim" ]]; then
    printf "Linking init.vim and configuring neovim... "
    mkdir -p ~/.config/nvim
    ln -sf "$(realpath init.vim)" "$HOME/.config/nvim/init.vim"
    nvim +PlugInstall +qa
    printf "done! \n"
else
    printf "Looks like init.vim already exists! \n"
fi

# link zshrc
if [[ ! -e "$HOME/.zshrc" ]]; then
    printf "Linking .zshrc ... "
    ln -sf "$(realpath zshrc)" "$HOME/.zshrc"
    printf "loading zshrc... "
    source zshrc
    printf "done! \n"
else
    printf "Looks like .zshrc already exists! \n"
fi

# link gitconfig
if [[ ! -e "$HOME/.gitconfig" ]]; then
    UNAME=$(uname)
    if [[ "$UNAME" == "Darwin" ]]; then
        ln -sf "$(realpath gitconfig.mac)" "$HOME/.gitconfig"
        printf "gitconfig.mac linked to ~/.gitconfig\n"
    elif [[ "$UNAME" == "Linux" ]]; then
        ln -sf "$(realpath gitconfig.linux)" "$HOME/.gitconfig"
        printf "gitconfig.linux linked to ~/.gitconfig\n"
    fi
else
    printf "Looks like .gitconfig already exists! \n"
fi

# create gpg config directory if it is missing
if [[ ! -d "$HOME/.gnupg" ]] && hash gpg 2>/dev/null; then
    printf "Creating ~/.gnupg directory since it is missing... "
    mkdir -p "$HOME/.gnupg"
    printf "done! \n"
fi

# link gpg config
if [[ ! -e "$HOME/.gnupg/gpg.conf" && -d "$HOME/.gnupg" ]]; then
    printf "Linking gpg config... "
    ln -sf "$(realpath gpg.conf)" "$HOME/.gnupg/gpg.conf"
    printf "done! \n"
else
    printf "Looks like gpg.conf already exists! \n"
fi

# link gpg agent config
if [[ ! -e "$HOME/.gnupg/gpg-agent.conf" && -d "$HOME/.gnupg" ]]; then
    printf "Linking gpg agent config... "
    ln -sf "$(realpath gpg-agent.conf)" "$HOME/.gnupg/gpg-agent.conf"
    printf "done! \n"
else
    printf "Looks like gpg-agent.conf already exists! \n"
fi

# create local fonts directory
if [[ $(uname) == "Linux" ]]; then
    if [[ ! -d "$HOME/.local/share/fonts" ]]; then
        printf "Creating ~/.local/share/fonts directory since it is missing... "
        mkdir -p "$HOME/.local/share/fonts"
        printf "done! \n"
    fi

    # link fonts
    for font in fonts/*.ttf; do
        if [[ ! -e "$HOME/.local/share/$font" ]]; then
            printf "Linking (%s) to $HOME/.local/share/$font ... " "$font"
            ln -sf "$(realpath "$font")" "$HOME/.local/share/$font"
            printf "done! \n"
        else
            printf "(%s) already linked! \n" "$font"
        fi
    done
fi
