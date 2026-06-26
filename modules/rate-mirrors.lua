return {
    description = "Arch Linux Rate Mirrors module",
    packages = {"rate-mirrors"},
    post_install_hook = "scripts/rate-mirrors.sh",
    hook_behaviour = "once"
}
