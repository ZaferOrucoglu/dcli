import ".."
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: timeRow

    SystemClock {
        id: time
        precision: SystemClock.Minutes
    }
    Text {
        id: timeText
        text: Qt.formatDateTime(time.date, "hh:mm") 
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        color: "#cdd6f4"
        font: Settings.fontConfig
    }
}
