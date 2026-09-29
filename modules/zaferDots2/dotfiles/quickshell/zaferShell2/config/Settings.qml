pragma Singleton

import QtQuick
QtObject {
  id: root

  property string theme: "kDragon"
  readonly property var currentTheme: themes[theme]|| themes.kDragon
  readonly property var themes: ({
    kDragon: {
      bg:     "#181616",
      bg2:    "#0d0c0c",
      bg3:    "#1e1c1c",
      bg4:    "#282727",
      fg:     "#c5c9c5",
      red:    "#c4746e",
      orange: "#e46876",
      yellow: "#c4b28a",
      green:  "#8a9a7b",
      aqua:   "#8ea4a2",
      blue:   "#8ba4b0",
      purple: "#a292a3",
      gray0:  "#0d0c0c",
      gray1:  "#a6a69c",
      gray2:  "#c8c093"
    },
    cMocha: {
      bg:     "#11111b",
      bg2:    "#1e1e2e",
      bg3:    "#313244",
      bg4:    "#45475a",
      fg:     "#cdd6f4",
      red:    "#f38ba8",
      orange: "#f37799",
      yellow: "#f9e2af",
      green:  "#a6e3a1",
      aqua:   "#94e2d5",
      blue:   "#89b4fa",
      purple: "#f5c2e7",
      gray0:  "#45475a",
      gray1:  "#585b70",
      gray2:  "#a6adc8"
    }
  })

  property font defaultFont: Qt.font({family:"Rubik", pixelSize: 18})
  
  property var notifications: ({
    timeout: 3000,
    hideOnFullscreen: true,
    allowCriticalInFullscreen: true
  })
}
