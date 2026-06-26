import ".."
import QtQuick
import Quickshell.Services.Mpris
import QtQuick.Layouts

Item {
    id: media
    implicitWidth: mediaRow.implicitWidth 
    implicitHeight: mediaRow.implicitHeight

    RowLayout {
        id: mediaRow
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter            
    

        Text {
            id: mediaText
            elide: Text.ElideRight
            Layout.maximumWidth: 150
            Layout.preferredWidth: (playing && playing.trackTitle) ? Math.min(implicitWidth, 150 ) : 0

            property var playing: Mpris.players.values[0]
            text: playing ? (playing.trackArtist + " - " + playing.trackTitle) : ""
            font: Settings.fontConfig
            color: "#cdd6f4"
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            if(event.button == Qt.RightButton){
                mediaText.playing.togglePlaying()
            }
        }
    }
}
