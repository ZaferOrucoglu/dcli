pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Scope {
  id: bat

  readonly property string chargeState: UPowerDeviceState.toString(UPower.displayDevice.state)
  readonly property int percentage: Math.round(UPower.displayDevice.percentage * 100)
  readonly property bool isLaptop: UPower.displayDevice.isLaptopBattery
  readonly property bool onBat: UPower.onBattery
}
