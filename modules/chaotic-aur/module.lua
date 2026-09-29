return {
    description = "Chaotic AUR installation module",
    post_install_hook = "scripts/chaotic-aur.sh",
    hook_behaviour = "once",
}

