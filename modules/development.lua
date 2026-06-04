local packages = {
    "docker",
    "docker-compose",
    "git",
    "zed",
    "vscodium",
    "opencode",
    "nvidia-container-toolkit",
    "qemu-full",
    "vm-curator-bin",
    -- antigravity-ide
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
