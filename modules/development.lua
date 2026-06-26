local packages = {
    "git",
    "curl",
    "wget",
    "zed",
    "neovim",
    "tree-sitter",
    "tree-sitter-cli",
    "lua-language-server",
    "bash-language-server",
    "filezilla",
    "remmina",
    "vscodium",
    "opencode",
    "podman",
    "podman-compose",
    "nvidia-container-toolkit",
    "qemu-full",
    "vm-curator-bin",
}

local services = {
    enabled = {
    },

    disabled = {

    }
}

return {
    description = "Development packages",
    packages = packages,
    services = services
}
