import QtQuick
import Quickshell
import "../../config"

Item {
  id: timeWrapper
  anchors {
    horizontalCenter: parent.horizontalCenter
    top: parent.top
    topMargin: 5 
  }
  width: 125; height: 35
  Text {
    id: timeText
    text: Qt.formatDateTime(time.date, "hh:mm")
    anchors.centerIn: parent
    color: Settings.currentTheme.fg
    font: Settings.defaultFont 
  }
  SystemClock {
    id: time
    precision: SystemClock.Minutes
  }
}
