if status is-interactive
# Commands to run in interactive sessions can go here
    set fish_greeting
end

function nvim
    command nvim --listen /tmp/nvim.pipe $argv
end

starship init fish | source
fish_add_path /home/zafer/.spicetify


# opencode
fish_add_path /home/zafer/.opencode/bin
