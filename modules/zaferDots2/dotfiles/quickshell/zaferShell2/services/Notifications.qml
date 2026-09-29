pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import Quickshell.Hyprland 
import "../config"
Scope {
  id: root
  property alias historyList: history
  property alias tracked: server.trackedNotifications

  property bool centerOpen: false
  property bool isFullscreen: (Hyprland.focusedWorkspace?.hasFullscreen ?? false)

  onIsFullscreenChanged : {
    if (!isFullscreen || !Settings.notifications.hideOnFullscreen) return;
    for (let i = server.trackedNotifications.values.length - 1; i >= 0; --i) {
      const n = server.trackedNotifications.values[i];
      if (Settings.notifications.allowCriticalInFullscreen && n.urgency === NotificationUrgency.Critical) continue;
      n.dismiss();
    }
  }
  ListModel {
    id: history
  }

  NotificationServer {
    id: server
    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: n => {
      history.insert(0, {
        notifId: n.id,
        summary: n.summary,
        body: n.body,
        appName: n.appName,
        desktopEntry: n.desktopEntry,
        urgency: n.urgency,
        image: n.image,
        appIcon: n.appIcon,
        time: Qt.formatDateTime(new Date(), "HH:mm")
      })
      if (history.count > 50) history.remove(50)
      const blocked = Settings.notifications.hideOnFullscreen && root.isFullscreen && !(Settings.notifications.allowCriticalInFullscreen && n.urgency === NotificationUrgency.Critical);
      if (blocked) return;
      n.tracked = true

      if (server.trackedNotifications.values.length > 1) {
        for (const v of server.trackedNotifications.values) {
          if ( v !== n ) {
            v.dismiss()
            break
          }
        }
      }
    }
  }

  IpcHandler {
    target: "notifications"
    function toggle(): void {root.centerOpen = !root.centerOpen}
    function show(): void {root.centerOpen = true}
    function hide(): void {root.centerOpen = false}
  }
}
