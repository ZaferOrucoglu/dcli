import QtQuick
import Quickshell 
import "../components"
import "../widgets/bar"
import "../services"
PanelWindow {
  id: root

  implicitHeight: 500
  exclusiveZone: 35
  anchors{ top: true; left: true; right: true;}

  margins.top: 5
  color: "transparent"
  mask: Region { item: island }
  Island {
    id: island
    timeHeight: timeItem.height ; contentHeight: notiCenter.contentHeight
    heightState: Notifications.centerOpen ? "centerHeight" : (Notifications.tracked.values.length > 0 && !Notifications.centerOpen) ? "popupHeight" : (island.hovered && !Notifications.centerOpen) ? "hoveredHeight" : "defaultHeight"
    widthState: Notifications.centerOpen ? "centerWidth" : (Notifications.tracked.values.length > 0 && !Notifications.centerOpen) ? "popupWidth" : (island.hovered && !Notifications.centerOpen) ? "hoveredWidth" : "defaultWidth"
    radius: 35
    
    Clock{ 
      id: timeItem 
    }
    
    Center{
      id: notiCenter
      hovered: parent.hovered

      anchors.top: timeItem.bottom
      anchors.bottomMargin: 45
    }
  }
}

