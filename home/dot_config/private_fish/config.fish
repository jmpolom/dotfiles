if status is-interactive
    # Commands to run in interactive sessions can go here
    if string match -q 'Darwin' -- $(uname)
        fish_add_path -P /opt/homebrew/bin
    end

    fish_add_path -P ~/.local/bin
end
