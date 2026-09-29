import QtQuick
import "../config"

Rectangle {
    id: island
    property bool hovered: hoverArea.containsMouse
    property color bgColor: Settings.currentTheme.bg2
    property int timeHeight: 35; property int contentHeight: 0 // just placeholder
    required property string heightState
    required property string widthState

    height: {
      switch(heightState){
        case "centerHeight": return timeHeight + contentHeight + 10
        case "popupHeight": return timeHeight + contentHeight + 20
        case "hoveredHeight": return timeHeight + contentHeight + 50
        case "defaultHeight": return 45 
      }
    }

    width: {
      switch(widthState){
        case "centerWidth": return 400
        case "popupWidth": return 400
        case "hoveredWidth": return 400
        case "defaultWidth": return 200
      }
    }
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    radius: height/2
    color: bgColor
    clip: true

    MouseArea {
      id: hoverArea
      anchors.fill: parent
      hoverEnabled: true
    }
    Behavior on width { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
    Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
}
