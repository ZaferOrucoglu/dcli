-- dcli configuration
-- This is a dynamic Lua configuration that adapts to your system
-- See LUA-HOSTS.md for full documentation

local hostname = dcli.system.hostname()
local is_laptop = dcli.hardware.is_laptop()
local memory_mb = dcli.system.memory_total_mb()

dcli.log.info(string.format("Loading config for %s (%d MB RAM)", hostname, memory_mb))

-- ═══════════════════════════════════════════════════════════════════
-- MODULE SELECTION
-- ═══════════════════════════════════════════════════════════════════

local enabled_modules = {
    "base",
    "development",
    "zaferDots2",
    "gaming",
    "easyeffects"
    -- Add your modules here
}

-- Example: Add GPU drivers based on hardware detection
-- if dcli.hardware.has_nvidia() then
--     table.insert(enabled_modules, "nvidia-drivers")
-- elseif dcli.hardware.has_amd_gpu() then
--     table.insert(enabled_modules, "amd-drivers")
-- end

-- Example: Add laptop-specific modules
-- if is_laptop then
--     table.insert(enabled_modules, "laptop-power")
-- end

-- ═══════════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════════

local services = {
    enabled = {},
    disabled = {},
}

-- Example: Enable docker if module is enabled
-- if dcli.util.contains(enabled_modules, "docker") then
--     table.insert(services.enabled, "docker.service")
-- end

-- ═══════════════════════════════════════════════════════════════════
-- RETURN CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════

return {
    host = hostname,
    description = "Zafer's Laptop",

    enabled_modules = enabled_modules,

    -- Host-specific packages (in addition to modules)
    packages = {},

    -- Packages to exclude from modules
    exclude = {},

    -- Services configuration
    services = services,

    -- Default applications
    default_apps = {
        browser = "helium",
        terminal = "kitty",
        text_editor = "dev.zed.Zed",
        file_manager = "org.gnome.Nautilus.desktop",
    },

    -- Settings
    flatpak_scope = "user",
    auto_prune = false,
    module_processing = "parallel",
    aur_helper = "yay",

    -- Backup settings
    config_backups = {
        enabled = true,
        max_backups = 5,
    },

    system_backups = {
        enabled = true,
        backup_on_sync = true,
        backup_on_update = true,
        tool = "timeshift",
        snapper_config = "root",
    },
}
