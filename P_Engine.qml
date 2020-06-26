import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "."

Page {
  id: enginePage

  //needed to restore the values of the components when Drawer re-inits the page
  onFocusChanged: {
    //console.log("engineRPMValue = ", MyGlobal.engineRPMValue, " -- ", c_Engine.c_value)

    c_Engine.c_state = MyGlobal.engineRPMState
    c_Engine.c_value = MyGlobal.engineRPMValue
    c_Engine.c_measure = MyGlobal.engineRPMMeasure
    c_Engine.c_srcName = MyGlobal.engineRPMSrcName

    c_EngineTemp.c_state = MyGlobal.engineTempState
    c_EngineTemp.c_value = MyGlobal.engineTempValue
    c_EngineTemp.c_measure = MyGlobal.engineTempMeasure
    c_EngineTemp.c_srcName = MyGlobal.engineTempSrcName

    c_Fuel.c_state = MyGlobal.fuelState
    c_Fuel.c_value = MyGlobal.fuelValue
    c_Fuel.c_measure = MyGlobal.fuelMeasure
    c_Fuel.c_srcName = MyGlobal.fuelSrcName

    c_OilPressure.c_state = MyGlobal.oilState
    c_OilPressure.c_value = MyGlobal.oilValue
    c_OilPressure.c_measure = MyGlobal.oilMeasure
    c_OilPressure.c_srcName = MyGlobal.oilSrcName

    c_Battery.c_state = MyGlobal.batteryState
    c_Battery.c_value = MyGlobal.batteryValue
    c_Battery.c_measure = MyGlobal.batteryMeasure
    c_Battery.c_srcName = MyGlobal.batterySrcName

    c_CoolantTemp.c_state = MyGlobal.coolantTempState
    c_CoolantTemp.c_value = MyGlobal.coolantTempValue
    c_CoolantTemp.c_measure = MyGlobal.coolantTempMeasure
    c_CoolantTemp.c_srcName = MyGlobal.coolantTempSrcName
  }

  width: MyStyle.panelWidth
  height: MyStyle.panelHeight

  background: Rectangle {
    color: MyStyle.backColor
  }

  title: qsTr("Engine Status")

  Grid {
    id: grid
    anchors {
      fill: parent;
      margins: 0
    }
    columns: 3
    columnSpacing: MyStyle.columnSpacing
    leftPadding: MyStyle.columnSpacing

    topPadding: MyStyle.rowSpacing
    rowSpacing: MyStyle.rowSpacing

    /////////////////////////////////////////////////
    Comp {
      id: c_Engine
      c_objectName: "c_Engine"
      c_state: 0
      c_value: 518
      c_measure: qsTr(" rpm")
      c_srcName: "Images/engine.png"

      Layout.row: 1
      Layout.column: 0
      Layout.alignment: Qt.AlignHCenter

      Connections {
        target: MyGlobal
        onEngineRPMStateChanged: {
          console.log("engineRPMStateChanged = ", MyGlobal.engineRPMState)
          c_Engine.c_state = MyGlobal.engineRPMState
        }
      }

      Connections {
        target: MyGlobal
        onEngineRPMValueChanged: {
          c_Engine.c_value = MyGlobal.engineRPMValue
        }
      }

      Connections {
        target: MyGlobal
        onEngineRPMSrcNameChanged: {
          c_Engine.c_srcName = MyGlobal.engineRPMSrcName
        }
      }

      Connections {
        target: MyGlobal
        onEngineRPMMeasureChanged: {
          c_Engine.c_measure = MyGlobal.engineRPMMeasure
        }
      }
    }

    /////////////////////////////////////////////////
    Comp {
      id: c_Fuel
      c_objectName: "c_Fuel"
      c_value: 48.2
      c_measure: qsTr("%")
      c_srcName: "Images/fuel.png"

      Connections {
        target: MyGlobal
        onFuelStateChanged: {
          c_Fuel.c_state = MyGlobal.fuelState
        }
      }

      Connections {
        target: MyGlobal
        onFuelValueChanged: {
          c_Fuel.c_value = MyGlobal.fuelValue
        }
      }

      Connections {
        target: MyGlobal
        onFuelSrcNameChanged: {
          c_Fuel.c_srcName = MyGlobal.fuelSrcName
        }
      }

      Connections {
        target: MyGlobal
        onFuelMeasureChanged: {
          c_Fuel.c_measure = MyGlobal.fuelMeasure
        }
      }

    }

    /////////////////////////////////////////////////
    Comp {
      id: c_OilPressure
      c_objectName: "c_OilPressure"
      c_value: 40
      c_measure: qsTr("psi")
      c_srcName: "Images/oil.png"

      Connections {
        target: MyGlobal
        onOilStateChanged: {
          c_OilPressure.c_state = MyGlobal.oilState
        }
      }

      Connections {
        target: MyGlobal
        onOilValueChanged: {
          c_OilPressure.c_value = MyGlobal.oilValue
        }
      }

      Connections {
        target: MyGlobal
        onOilSrcNameChanged: {
          c_OilPressure.c_srcName = MyGlobal.oilSrcName
        }
      }

      Connections {
        target: MyGlobal
        onOilMeasureChanged: {
          c_OilPressure.c_measure = MyGlobal.oilMeasure
        }
      }

    }

    /////////////////////////////////////////////////
    Comp {
      id: c_EngineTemp
      c_objectName: "c_EngineTemp"
      c_value: 244.5
      c_measure: MyStyle.centigradeStr
      c_srcName: "Images/liquid_temperature.png"

      Connections {
        target: MyGlobal
        onEngineTempStateChanged: {
          c_EngineTemp.c_state = MyGlobal.engineTempState
        }
      }

      Connections {
        target: MyGlobal
        onEngineTempValueChanged: {
          c_EngineTemp.c_value = MyGlobal.engineTempValue
        }
      }

      Connections {
        target: MyGlobal
        onEngineTempSrcNameChanged: {
          c_EngineTemp.c_srcName = MyGlobal.engineTempSrcName
        }
      }

      Connections {
        target: MyGlobal
        onEngineTempMeasureChanged: {
          c_EngineTemp.c_measure = MyGlobal.engineTempMeasure
        }
      }

    }

    ////////////////////////////////////////////////////////
    Comp {
      id: c_Battery
      c_objectName: "c_Battery"
      c_value: 14.8
      c_measure: qsTr(" Vdc")
      c_srcName: "Images/battery.png"

      Connections {
        target: MyGlobal
        onBatteryStateChanged: {
          c_Battery.c_state = MyGlobal.batteryState
        }
      }

      Connections {
        target: MyGlobal
        onBatteryValueChanged: {
          c_Battery.c_value = MyGlobal.batterylValue
        }
      }

      Connections {
        target: MyGlobal
        onBatterySrcNameChanged: {
          c_Battery.c_srcName = MyGlobal.batterySrcName
        }
      }

      Connections {
        target: MyGlobal
        onBatteryMeasureChanged: {
          c_Battery.c_measure = MyGlobal.batteryMeasure
        }
      }
    }

    //////////////////////////////////////////
    Comp {
      id: c_CoolantTemp
      c_objectName: "c_CoolantTemp"
      c_value: 190
      c_measure: MyStyle.centigradeStr
      c_srcName: "Images/coolant.png"

      Connections {
        target: MyGlobal
        onCoolantTempStateChanged: {
          c_CoolantTemp.c_state = MyGlobal.coolantTempState
        }
      }

      Connections {
        target: MyGlobal
        onCoolantTempValueChanged: {
          c_CoolantTemp.c_value = MyGlobal.coolantTempValue
        }
      }

      Connections {
        target: MyGlobal
        onCoolantTempSrcNameChanged: {
          c_CoolantTemp.c_srcName = MyGlobal.coolantTempSrcName
        }
      }

      Connections {
        target: MyGlobal
        onCoolantTempMeasureChanged: {
          c_CoolantTemp.c_measure = MyGlobal.coolantTempMeasure
        }
      }
    }
  }
}
