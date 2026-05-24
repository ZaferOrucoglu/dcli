--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "satty",
    match = {
        title = "satty",
    },
    float = true,
})

hl.window_rule {
    name = "ATLauncher console",
    match = {
        title = "ATLauncher Console",
    },
    float = true,
}

hl.layer_rule {
    name = "rofi-dropdown",
    match = { namespace = "rofi" },
    animation = "slide bottom",
    dim_around = true,
}

hl.layer_rule {
    name = "notification",
    match = { namespace = "swaync-control-center" },
    animation = "slide top"
}

hl.window_rule({
    name = "kitty",
    match = { class = "kitty" },
    opacity = 0.95
})

hl.window_rule({
    name = "screen-share",
    match = { class = "hyprland-share-picker" },
    float = true
})
