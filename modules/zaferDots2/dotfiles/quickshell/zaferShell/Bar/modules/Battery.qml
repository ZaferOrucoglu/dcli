import ".."
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
RowLayout {
    id: batteryRow
    Layout.preferredWidth: 1
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

    property var chargePercentage: Math.round(UPower.displayDevice.percentage * 100)  
    property var stateCharge: UPower.displayDevice.state
    function getIcon(chargePercentage, stateCharge){
        if(stateCharge == UPowerDeviceState.Charging){
            if (chargePercentage >= 90) return "󰂅 "  // battery-charging-100
            if (chargePercentage >= 80) return "󰂋 "
            if (chargePercentage >= 60) return "󰂊 "
            if (chargePercentage >= 50) return "󰢞 "
            if (chargePercentage >= 40) return "󰂉 "
            if (chargePercentage >= 30) return "󰂈 "
            if (chargePercentage >= 20) return "󰂇 "
            return "󰢟 "
        } 

        if (chargePercentage >= 95) return "󰁹"
        if (chargePercentage >= 90) return "󰂂"
        if (chargePercentage >= 80) return "󰂁"
        if (chargePercentage >= 70) return "󰂀"
        if (chargePercentage >= 60) return "󰁿"
        if (chargePercentage >= 50) return "󰁾"
        if (chargePercentage >= 40) return "󰁽"
        if (chargePercentage >= 30) return "󰁼"
        if (chargePercentage >= 20) return "󰁻"
        if (chargePercentage >= 10) return "󰁺"
        return "󰂎"
    }

    Text {
        id: batteryText
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        topPadding: 2
        text: batteryRow.getIcon(batteryRow.chargePercentage, batteryRow.stateCharge) + " " + batteryRow.chargePercentage + "%"
        font: Settings.fontConfig
        color: "#cdd6f4"
    }
}
