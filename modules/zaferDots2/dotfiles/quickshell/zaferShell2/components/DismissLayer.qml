import QtQuick
import Quickshell
import "../services"

PanelWindow {
  anchors {top: true; bottom: true; right: true; left: true}
  exclusionMode: ExclusionMode.Ignore
  color: "transparent"
  mask: Notifications.centerOpen ? fullMask : emptyMask

  Region {id: fullMask; item: catcher}
  Region {id: emptyMask; width: 0; height: 0}

  MouseArea {
    id: catcher
    anchors.fill: parent
    onClicked: Notifications.centerOpen = false
  }
}

