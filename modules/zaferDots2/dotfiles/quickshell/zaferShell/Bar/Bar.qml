//@ pragma UseQApplication
import Quickshell
import Quickshell.Wayland
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.UPower

import "./modules"
Variants {
    model: Quickshell.screens

    PanelWindow {
        required property ShellScreen modelData
        WlrLayershell.namespace: "zaferBar"
        screen: modelData

        implicitWidth: layout.implicitWidth
        implicitHeight: 35
        anchors {top: true; left: true; right: true}
        margins.top: 8
        color: "transparent"

        RowLayout {
            id: layout    
            anchors.fill: parent
            spacing: 8
            
            Item {
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.fillHeight: true

                Rectangle {
                    id: leftGroup
                    anchors.left: parent.left
                    height: parent.height
                    width: leftRow.implicitWidth + 32
                    radius: 15

                    color: "#181825"
                    border {width:2; color: "#89b4fa"}
                    Row {
                        id: leftRow
                        anchors.centerIn: parent
                        spacing: 8

                        Loader {
                            active: true
                            source: "modules/Time.qml"
                        }
                        Loader {
                            active: true
                            source: "modules/Volume.qml"
                        }
                        Loader {
                            active: true
                            source: "modules/Media.qml"
                        }

                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.fillHeight: true

                Rectangle {
                    id: middleGroup
                    anchors.centerIn: parent
                    height: parent.height
                    width: middleRow.implicitWidth + 32
                    radius: 15

                    color: "#181825"
                    border {width:2; color: "#89b4fa"}
                    Row {
                        id: middleRow
                        anchors.centerIn: parent
                        spacing: 8

                        Loader {
                            active: true
                            source: "modules/Workspaces.qml"
                        }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.fillHeight: true

                Rectangle {
                    id: rightGroup
                    anchors.right: parent.right
                    height: parent.height
                    width: rightRow.implicitWidth + 32
                    radius: 15

                    color: "#181825"
                    border {width: 2; color: "#89b4fa"}

                    Row {
                        id: rightRow
                        anchors.centerIn: parent
                        spacing: 8

                        Loader {
                            active: true
                            source: "modules/Tray.qml"
                        } 

                        Loader {
                            active: true
                            source: "modules/Battery.qml"
                        } 
                    }
                }
            }
        }
    }
}
