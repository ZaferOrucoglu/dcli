import ".."
import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell.Io

Item {
    implicitWidth: volumeRow.implicitWidth
    implicitHeight: volumeRow.implicitHeight

    MouseArea {
        anchors.fill: parent
        onClicked: openpavu.running = true
        
        onWheel: event => {
            const delta = event.angleDelta.y > 0 ? 0.05 : -0.05
            const sink = Pipewire.defaultAudioSink
            if (sink) sink.audio.volume = Math.max(0,Math.min(1,sink.audio.volume + delta))
        }
    }

    RowLayout {
        id: volumeRow
        anchors.centerIn: parent

        Scope {
            id: model
            property int percentage: Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) ?? 0
            property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? true

            PwObjectTracker {
                objects: [Pipewire.defaultAudioSink]
            }
        }

        Text {
            id: volumeText
            topPadding: -1

            readonly property int percentage: model.percentage
            readonly property bool muted: model.muted
            property string content: getIcon(percentage, muted)  + " " + getVolume(percentage, muted) 

            function getIcon(percentage, discharging) {
                if (muted) return " "
                if (percentage == 100) return "  "
                if (percentage >= 10) return "  "
                return " "
            }

            function getVolume(percentage, discharging) {
                if (muted) return "muted"
                if (percentage==0) return "0"
                return percentage.toString().padStart(2,"0")
            }
            text: content; 
            color: muted ? "#f38ba8" : "#cdd6f4"
            font: Settings.fontConfig 
        }

        Process {
            id: openpavu
            command: ["pavucontrol"]
            running: false
        }
    }

}
