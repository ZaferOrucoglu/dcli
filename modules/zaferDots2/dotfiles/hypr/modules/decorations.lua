-----------------------
---- LOOK AND FEEL ----
-----------------------
local colors = require("colors/kDragon")
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 8,
        gaps_out         = 20,

        border_size      = 1,

        col              = {
            active_border   = { colors = { "rgba(" .. colors.red .. "ee)" } },
            inactive_border = "rgba(" .. colors.gray1 .. "aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,
    },

    decoration = {
        rounding         = 15,
        rounding_power   = 5,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.9,

        shadow           = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            color        = 0xee0a0a0a,
        },

        blur             = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easeInOutBack", { type = "bezier", points = { { 0.68, -0.6 }, { 0.32, 1.6 } } })
hl.curve("easeInOutQuart", { type = "bezier", points = { { 0.76, 0 }, { 0.24, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeInOutExpo", { type = "bezier", points = { { 0.87, 0 }, { 0.13, 1 } } })
hl.curve("easeOutStrongQuint", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.33, 1 }, { 0.68, 1 } } })
hl.curve("easeOutBack", { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 } } })

-- Springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve("snappy", { type = "spring", mass = 0.51, stiffness = 150, dampening = 15 })
hl.curve("bouncy", { type = "spring", mass = 1, stiffness = 100, dampening = 8 })
hl.curve("weighted", { type = "spring", mass = 2, stiffness = 80, dampening = 20 })
hl.curve("gentle", { type = "spring", mass = 1.0, stiffness = 40, dampening = 25 })

-- Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

hl.animation({ leaf = "windows", enabled = true, speed = 5.5, spring = "snappy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOutBack" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "easeOutQuint" })

hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })

hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fadePopups", enabled = true, speed = 2, bezier = "quick" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 3, bezier = "easeOutQuint" })

hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "slidefade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 4.5, spring = "gentle" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.5, spring = "gentle" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 6.5, bezier = "easeOutCirc" })
