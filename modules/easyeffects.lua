local packages = {
    "easyeffects",
    "lsp-plugins",
    "gst-plugin-pipewire"
}

return {
    description = "EasyEffects installation module.",
    packages = packages,
    post_install_hook = "scripts/deepfilternet.sh"
}
