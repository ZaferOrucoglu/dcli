import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: workspacesRow
    
    Repeater {
        id: rep
        model: Hyprland.workspaces
        property font activeFont: Qt.font( {pixelSize: 20, family: "Rubik"} )
        property font inactiveFont: Qt.font( {pixelSize: 16, family: "Rubik"} )

        Text {
            width: 16

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace = '${modelData.id}'})`)
            }

            Text {
                text: modelData.id
                anchors.centerIn: parent
                color: modelData.active ? "#89b4fa":"#cdd6f4"
                font: modelData.active ? rep.activeFont : rep.inactiveFont
            }
        }
    }
}
