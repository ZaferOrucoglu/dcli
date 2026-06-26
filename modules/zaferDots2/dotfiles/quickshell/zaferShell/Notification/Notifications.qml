import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "config.js" as Config

Scope {
    id: root
    property bool centerOpen: false
    property var activePopups: []

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
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm")
            })
            n.tracked = true
            root.activePopups.push(n)
            if (root.activePopups.length > 3) { 
                let oldest = root.activePopups.shift() 
                oldest.dismiss() 
            }
        }
    }

    IpcHandler {
        target: "notifications"
        function toggle(): void {root.centerOpen = !root.centerOpen}
        function show(): void {root.centerOpen = true}
        function hide(): void {root.centerOpen = false}
    }

    // single notification
    PanelWindow {
        anchors.top:true
        margins.top: Config.bar.height + 16
        
        implicitWidth: 380
        implicitHeight: Math.max(1,column.implicitHeight)
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: column
            width: parent.width
            spacing: 10

            Repeater {
                model: server.trackedNotifications
                delegate: Rectangle {
                    id: card
                    required property var modelData

                    Timer {
                        running: card.modelData.urgency !== NotificationUrgency.Critical
                        interval: Config.notifications.timeout
                        onTriggered: card.modelData.dismiss()
                    }

                    Layout.fillWidth: true
                    Layout.preferredHeight: layout.implicitHeight + 20
                    radius: 8
                    color: Config.colors.bg
                    border.width: 2
                    border.color: modelData.urgency === NotificationUrgency.Critical ? Config.colors.red : Config.colors.blue

                    RowLayout {
                        id: layout
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Image {
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 46
                            Layout.alignment: Qt.AlignTop
                            fillMode: Image.PreserveAspectFit
                            visible: source.toString() !== ""
                            source: card.modelData.image || card.modelData.appIcon || ""
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                Layout.fillWidth: true
                                text: card.modelData.summary
                                color: Config.colors.cyan
                                font.family: Config.bar.fontFamily
                                font.pixelSize: Config.bar.fontSize
                                font.bold: true
                                elide: Text.ElideRight
                            }

                            Text {
                                Layout.fillWidth: true
                                visible: text !== ""
                                text: card.modelData.body
                                color: Config.colors.fg
                                font.family: Config.bar.fontFamily
                                font.pixelSize: Config.bar.fontSize - 1
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            let idx = root.activePopups.indexOf(card.modelData)
                            if (idx !== -1) {
                                root.activePopups.splice(idx, 1)
                            }
                            card.modelData.dismiss()
                        }
                    }
                }
            }
        }
    }

    // notification center
    PanelWindow {
        visible: root.centerOpen

        anchors.top: true
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore

        MouseArea {
            anchors.fill: parent
            onClicked: root.centerOpen = false
        }

        Rectangle {
            width: 380
            height: Math.min(centerCol.implicitHeight + 24, 400)

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: Config.bar.height + 16
            anchors.rightMargin: 12 

            radius: 10
            color: Config.colors.bg
            border.width: 2
            border.color: Config.colors.blue

            MouseArea {
                anchors.fill: parent
            }

            ColumnLayout {
                id: centerCol
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                RowLayout {
                    Layout.fillWidth: true
                    
                    Text {
                        Layout.fillWidth: true
                        text: "Notifications"
                        color: Config.colors.blue
                        font.family: Config.bar.fontFamily
                        font.pixelSize: Config.bar.fontSize + 2
                        font.bold: true
                    }

                    Text {
                        text: "Clear all"
                        visible: history.count > 0
                        color: Config.colors.red
                        font.family: Config.bar.fontFamily
                        font.pixelSize: Config.bar.fontSize - 1

                        MouseArea {
                            anchors.fill: parent
                            onClicked: history.clear()
                        }
                    }
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                    ColumnLayout {
                        width: parent.width

                        Repeater {
                            model: history
                            delegate: Rectangle {
                                Layout.fillWidth: true
                                implicitHeight: Math.max(cardLayout.implicitHeight + 16, 60)
                                radius: 8
                                color: "transparent"
                                border.width: 1
                                border.color: Config.colors.muted
                                Layout.topMargin: 4
                                Layout.bottomMargin: 4
                                
                                ColumnLayout {
                                    id: cardLayout
                                    anchors.fill: parent
                                    anchors.margins: 8
                                    spacing: 2

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 6

                                        Text {
                                            Layout.fillWidth: true
                                            text: model.summary
                                            color: Config.colors.fg
                                            font.family: Config.bar.fontFamily
                                            font.pixelSize: Config.bar.fontSize
                                            font.bold: true
                                            elide: Text.ElideRight
                                        }
                                        Text {
                                            text: model.time
                                            color: Config.colors.muted
                                            font.family: Config.bar.fontFamily
                                            font.pixelSize: Config.bar.fontSize - 3
                                        }
                                        Text {
                                            text: "x"
                                            color: Config.colors.muted
                                            font.family: Config.bar.fontFamily
                                            font.pixelSize: Config.bar.fontSize - 1
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: history.remove(index)
                                            }
                                        }
                                    }

                                    Text {
                                        Layout.fillWidth: true
                                        visible: text !== ""
                                        text: model.body
                                        color: Config.colors.fg
                                        font.family: Config.bar.fontFamily
                                        font.pixelSize: Config.bar.fontSize - 1
                                        wrapMode: Text.WordWrap
                                    }
                                    
                                    Text {
                                        visible: model.appName !== ""
                                        text: model.appName
                                        color: Config.colors.muted
                                        font.family: Config.bar.fontFamily
                                        font.pixelSize: Config.bar.fontSize - 3
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

