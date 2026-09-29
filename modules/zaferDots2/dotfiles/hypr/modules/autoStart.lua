-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
    hl.exec_cmd("xhost +SI:localuser:root")
    hl.exec_cmd("qs -p ~/.config/quickshell/zaferShell2/shell.qml")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("easyeffects -w")
    hl.exec_cmd("crossmacro --start-minimized")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,ssh,pkcs11")
end)
