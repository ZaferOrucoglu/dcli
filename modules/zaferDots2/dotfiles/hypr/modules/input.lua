---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout          = "tr",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "",
        kb_rules           = "",

        follow_mouse       = 1,

        sensitivity        = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad           = {
            natural_scroll = true,
        },

        numlock_by_default = true,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
