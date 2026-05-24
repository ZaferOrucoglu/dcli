local packagesArch = {
    "zapret-git",
    "dnscrypt-proxy"
}

local packagesFedora = {
    "zapret",
    "dnscrypt-proxy"
}

local packagesDebian = {
    "dnscrypt-proxy"
}

local archDistros = {
    "arch",
    "manjaro",
    "endeavour",
    "cachyos",
    "garuda"
}

local fedoraDistros = {
    "fedora",
    "nobara",
}

local debianDistros = {
    "debian",
    "ubuntu",
    "pop",
    "zorin",
    "linuxmint",
}
local d = dcli.system.distro()

local function contains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then return true end
    end
    return false
end

if contains(archDistros, d) then
    return {
        packages = packagesArch,
        post_install_hook = "scripts/postZapret-Arch.sh",
    }
elseif contains(fedoraDistros, d) then
    return {
        packages = packagesFedora,
        pre_install_hook = "scripts/preZapret-Fedora.sh",
        post_install_hook = "scripts/postZapret-Fedora.sh",
        hook_behaviour = "once",
    }
elseif contains(debianDistros, d) then
    return {
        packages = packagesDebian,
        pre_install_hook = "scripts/preZapret-Debian.sh",
        post_install_hook = "scripts/postZapret.sh",
        hook_behaviour = "once",
    }
end

return {
    description = "Installs Zapret and dnscrypt-proxy on Arch, Fedora, and Debian-based distros.",
    services = {
        enabled = {
            "dnscrypt-proxy",
            "zapret",
        },
        disabled = {}
    },
}
