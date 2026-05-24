local packages = {
    "docker",
    "docker-compose",
    "git",
    "zed",
    "vscodium",
    "opencode"
}

local services = {
    enabled = {
        "docker"
    },

    disabled = {

    }
}

return {
    description = "Development packages",
    packages = packages,
    services = services
}
