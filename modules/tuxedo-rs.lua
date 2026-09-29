return {
    description = "Tuxedo-rs installation module",
    packages = {
        "tuxedo-drivers-dkms",
        "tailord",
        "tailor-gui",
        "tailor-cli",
    },
    services = {
        enabled = {
            "tailord",
        },
        disabled = {},
    }
}
