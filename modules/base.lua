-- Base system packages
-- These packages are included regardless of host or modules
-- Uses Lua for conditional package selection based on hardware

local packages = {
    -- Essential base system
    "base",
    "base-devel",

    -- Kernel (uncomment the one you use)
    -- "linux",              -- Standard kernel
    -- "linux-zen",          -- Zen kernel (optimized for desktop)
    -- "linux-lts",          -- Long-term support kernel

    -- Firmware
    -- "linux-firmware",

    -- Basic tools
    -- "git",
    -- "vim",
    -- "neovim",
    -- "htop",

    -- dcli dependencies (uncomment as needed)
    -- "yay",       -- AUR helper
    -- "fzf",                -- Fuzzy finder (for dcli TUI)
    "timeshift",               -- System backup tool
}

-- Add CPU microcode based on vendor
local cpu = dcli.hardware.cpu_vendor()
if cpu == "intel" then
    dcli.log.info("Intel CPU detected - adding intel-ucode")
    table.insert(packages, "intel-ucode")
elseif cpu == "amd" then
    dcli.log.info("AMD CPU detected - adding amd-ucode")
    table.insert(packages, "amd-ucode")
end

return {
    description = "Base system packages",
    packages = packages,
}
