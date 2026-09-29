import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import "../config"
import "../services"

Rectangle {
  id: card

  required property string summary
  required property string body
  required property string imageSource
  required property string timeText
  required property string desktopEntry
  property int notifIndex: -1
  property int notifId: -1

  property int timeoutMs: 0
  property var notifObject: null

  signal expired
  Timer { running: card.timeoutMs > 0; interval: card.timeoutMs; onTriggered: card.expired() }
  width: 370
  height: 100
  radius: 15
  Layout.alignment: Qt.AlignHCenter
  color: Settings.currentTheme.bg
  opacity: 0

  Behavior on opacity { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
  Component.onCompleted: card.opacity = 1

  RowLayout {
    id: layout
    z: 1
    anchors.fill: parent
    anchors { leftMargin: 10; rightMargin: 10; topMargin: 8; bottomMargin: 8 }
    spacing: 10

    Image {
      Layout.preferredWidth: 46
      Layout.preferredHeight: 36
      Layout.alignment: Qt.AlignCenter
      fillMode: Image.PreserveAspectFit
      visible: source.toString() !== ""
      source: card.imageSource 
    }

    ColumnLayout {
      Layout.fillWidth: true
      Layout.minimumWidth: 0
      spacing: 2
      Layout.alignment: Qt.AlignTop

      RowLayout {
        Layout.fillWidth: true
        spacing: 6

        Text {
          Layout.fillWidth: true
          Layout.minimumWidth: 0
          text: card.summary
          color: Settings.currentTheme.gray1
          font { family: Settings.defaultFont.family; pixelSize: Settings.defaultFont.pixelSize - 3; bold: true }
          maximumLineCount: 1
          elide: Text.ElideRight
          clip: true
        }

        Text {
          text: card.timeText
          color: Settings.currentTheme.gray1
          font { family: Settings.defaultFont.family; pixelSize: Settings.defaultFont.pixelSize - 5 }
        }
      }

      Text {
        Layout.fillWidth: true
        visible: text !== ""
        text: card.body
        color: Settings.currentTheme.fg
        font { family: Settings.defaultFont.family; pixelSize: Settings.defaultFont.pixelSize - 3 }
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        maximumLineCount: 3
        elide: Text.ElideRight
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    function classCheck(){
      var e = DesktopEntries.byId(card.desktopEntry)
      if (e != null) return e.startupClass
      return ""
    }
    onClicked: (mouse)=>{
      if(mouse.button == Qt.LeftButton){
        if (card.desktopEntry !== "") {
          var cls = classCheck()
          if (cls !== "") Hyprland.dispatch('hl.dsp.focus({ window = "class:^(' + cls + ')$" })')
        }
      }
      else if (mouse.button == Qt.RightButton){
        if (card.notifObject) card.notifObject.dismiss()
        if (card.notifIndex >= 0) {
          const _id = card.notifId
          Notifications.historyList.remove(card.notifIndex)
          if (_id >= 0) {
            for (let i = Notifications.tracked.values.length - 1; i >= 0; --i) {
              if (Notifications.tracked.values[i].id === _id) Notifications.tracked.values[i].dismiss()
            }
          } else if (card.notifIndex === 0 && Notifications.tracked.values.length > 0) {
            Notifications.tracked.values[0].dismiss()
          }
        } else if (card.notifObject) {
          const _oid = card.notifObject.id
          for (let i = Notifications.historyList.count - 1; i >= 0; --i) {
            if (Notifications.historyList.get(i).notifId === _oid) {
              Notifications.historyList.remove(i)
              break
            }
          }
        }
      }
    }
  }
}
