-- Base system packages
-- These packages are included regardless of host or modules
-- Uses Lua for conditional package selection based on hardware

local packages = {
    -- Essential base system
    "base",
    "base-devel",
    "flatpak",
    "linux-zen",          -- Zen kernel (optimized for desktop)
    "linux-firmware",
    "yay",       -- AUR helper
    "fzf",                -- Fuzzy finder (for dcli TUI)
    "timeshift",               -- System backup tool
    "earlyoom",
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
    services = {enabled = {"earlyoom"}, disabled = {}}
}
