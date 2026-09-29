import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Notifications
import "../../components"
import "../../config"
import "../../services"

Rectangle {
  id: notiCenter
  required property bool hovered
  readonly property int contentHeight: {
    if (Notifications.centerOpen) return Math.min(Notifications.historyList.count * 100 + 40, 400)
    else if (Notifications.tracked.values.length > 0 && !Notifications.centerOpen) return 100
    else if (hovered && Notifications.historyList.count > 0 && Notifications.tracked.values.length === 0) return 100
    return 0
  }
  property bool shouldShow: Notifications.centerOpen || (hovered && Notifications.historyList.count > 0) || (!Notifications.centerOpen && Notifications.tracked.values.length > 0)

  width: 370; height: contentHeight
  anchors.horizontalCenter: parent.horizontalCenter
  color: "transparent"
  opacity: shouldShow ? 1 : 0
  visible: shouldShow || opacity > 0.01

  Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
  Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

  Rectangle {
    id: center
    width: parent.width; height: centerCol.height
    radius: 35
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    color: "transparent"
    opacity: Notifications.centerOpen ? 1 : 0
    visible: (opacity > 0.01 || Notifications.centerOpen)

    Behavior on opacity { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
    Behavior on anchors.topMargin { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }

    MouseArea {
      anchors.fill: parent
    }
    
    ColumnLayout {
      id: centerCol
      Layout.fillWidth: true
      height: Math.min(Notifications.historyList.count * 100 + 40, 400)
      spacing: 8 
      anchors.bottomMargin: 35
  
      RowLayout {
        id: centerRow
        Layout.fillWidth: true
  
        Text {
          Layout.fillWidth: true
          text: "Notifications"
          color: Settings.currentTheme.gray1
          font: Settings.defaultFont
        }
  
        Text {
          text: "Clear all"
          visible: Notifications.historyList.count>0
          color: Settings.currentTheme.red
          font: Settings.defaultFont
  
          MouseArea {
            anchors.fill: parent
            onClicked: {
              Notifications.historyList.clear()
              for (let i = Notifications.tracked.values.length - 1; i >= 0; --i) Notifications.tracked.values[i].dismiss()
            }
          }
        }
      }
      ScrollView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignTop
        Layout.topMargin: 8
        clip: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
  
        ColumnLayout {
          width: parent.width
  
          Repeater {
            model: Notifications.historyList
            delegate: NotificationCard {
              required property var model
              required property int index
              summary: model.summary
              body: model.body
              imageSource: model.image || model.appIcon || ""
              timeText: model.time
              desktopEntry: model.desktopEntry
              notifIndex: index
              notifId: model.notifId ?? -1
            }
          }
        }
      }
    }
  }

  ColumnLayout {
    id: hoverPreview
    opacity: (!Notifications.centerOpen && notiCenter.hovered && Notifications.historyList.count > 0 && Notifications.tracked.values.length ===0) ? 1 : 0
    visible: opacity > 0.01 || (!Notifications.centerOpen && notiCenter.hovered && Notifications.historyList.count > 0 && Notifications.tracked.values.length ===0)
    width: parent.width
    anchors {
      top: parent.top
      topMargin: 35
      horizontalCenter: parent.horizontalCenter
    }

    Behavior on opacity { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
    Repeater {
      model: Notifications.historyList.count > 0 ? [Notifications.historyList.get(0)] : []
      delegate: NotificationCard {
        required property var modelData
        summary: modelData.summary
        body: modelData.body
        imageSource: modelData.image || modelData.appIcon || ""
        timeText: modelData.time
        desktopEntry: modelData.desktopEntry
        notifIndex: 0
        notifId: modelData.notifId ?? -1
      }
    }
  }

  ColumnLayout {
    id: popup
    opacity: (!Notifications.centerOpen && Notifications.tracked.values.length > 0) ? 1 : 0
    visible: opacity > 0.01 || (!Notifications.centerOpen && Notifications.tracked.values.length > 0)
    width: parent.width
    anchors {
      bottom : parent.bottom
      horizontalCenter: parent.horizontalCenter
    }

    Repeater {
      model: Notifications.tracked
      delegate:  NotificationCard {
        required property var modelData
        notifObject: modelData
        notifId: modelData.id
        summary: modelData.summary
        body: modelData.body
        imageSource: modelData.image || modelData.appIcon || ""
        timeText: Qt.formatDateTime(new Date(), "HH:mm")
        desktopEntry: modelData.desktopEntry

        timeoutMs: modelData.urgency !== NotificationUrgency.Critical ? Settings.notifications.timeout : 0
        onExpired: modelData.dismiss() 
      }
    }
  }
}
