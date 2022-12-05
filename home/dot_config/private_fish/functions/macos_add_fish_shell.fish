function macos_add_fish_shell
    fgrep -qx (command -v fish) /etc/shells || echo (command -v fish) | sudo tee -a /etc/shells
end
