I have deleted light/dark mode switch. here is the proper code part of its button on button-grid
         {
           "label": "󰃟",
           "type": "toggle",
           "command": "bash -c '$HOME/.local/bin/themesw'",
           "update-command": "bash -c '[ $($HOME/.local/bin/themesw --current) = light ] && echo true || echo false'"
         },
