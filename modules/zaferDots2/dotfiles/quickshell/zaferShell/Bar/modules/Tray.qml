//@ pragma UseQApplication
import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

RowLayout {
    id: tray
    spacing: 8


    Repeater {
        model: SystemTray.items

        MouseArea {
            id: trayArea
            required property SystemTrayItem modelData
            property alias item: trayArea.modelData
            
            Layout.fillHeight: true
            implicitWidth: icon.implicitWidth + 8
            implicitHeight: icon.implicitHeight + 8
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            hoverEnabled: true

            onClicked: event => {
                if (event.button == Qt.LeftButton) {
                    item.activate();
                } else if (event.button == Qt.RightButton) {
                    menuAnchor.open();
                } else if (event.button == Qt.MiddleButton) {
                    item.secondaryActivate();
                }
            }

            onWheel: event => {
                event.accepted= true
                const points= event.angleDelta.y/ 120
                item.scroll(points, false);
            }

            IconImage {
                id: icon
                anchors.centerIn: parent
                source: item.icon
                implicitSize: 20
            }

            QsMenuAnchor {
                id: menuAnchor
                menu: item.menu

                anchor.window: trayArea.QsWindow.window
                anchor.adjustment: PopupAdjustment.Flip

                anchor.onAnchoring: {
                    const window = trayArea.QsWindow.window;
                    const widgetRect = window.contentItem.mapFromItem(trayArea, 0,trayArea.height, trayArea.width, trayArea.height)

                    menuAnchor.widget.rect = widgetRect;
                }
            }

//            Tooltip {
//                relativeItem: trayArea.conainsMouse ? trayArea: null
//
//                Label {
//                    text: trayArea.item.tooltipTitle || trayArea.item.id
//                }
//            }
        }
    }
}
