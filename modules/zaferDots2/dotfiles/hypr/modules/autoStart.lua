-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
    hl.exec_cmd("xhost +SI:localuser:root")
    hl.exec_cmd("qs -p ~/.config/quickshell/zaferShell/shell.qml")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("easyeffects -w")
end)
