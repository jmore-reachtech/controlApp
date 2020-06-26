import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "."

Page {
  id: homePage
  width: MyStyle.panelWidth
  height: MyStyle.panelHeight

  Rectangle {
    anchors.fill: parent
    color: MyStyle.backColor
  }

  title: qsTr("Main Page")

  property int cols: 3 //how many columns to display
  property int rws: 2 //how many rows to display
  property int colSpace: Math.round((width - MyStyle.dialWidth * cols) / (cols + 1))
  property int rowSpace: Math.round((height - MyStyle.statusBarHeight - MyStyle.dialHeight - MyStyle.componentY) / (rws + 1))

  Rectangle {
    width: parent.width - colSpace
    height: parent.height
    anchors {
      top: parent.top
      horizontalCenter: parent.horizontalCenter
    }
    color: MyStyle.backColor

    GridLayout {
      id: grid
      anchors {
        fill: parent;
        margins: {
          topMargin: rowSpace
        }
      }

      columns: cols
      columnSpacing: colSpace
      Layout.leftMargin: colSpace

      rows: rws
      rowSpacing: rowSpace
      Layout.topMargin: rowSpace

      C_SpeedDial {
        objectName: "flowDial"
        id: flowDial
        legendTxt: "Flow"
        units: "SCFM"
        state: 0
        Layout.row: 0
        Layout.column: 0
        Layout.alignment: Qt.AlignHCenter

        currentValue: MyGlobal.flowDial_currentValue
        measuredMaxValue: MyGlobal.flowDial_measuredMaxValue
        maxTxt: MyGlobal.flowDial_maxTxt
        measuredAvgValue: MyGlobal.flowDial_measuredAvgValue
        avgTxt: MyGlobal.flowDial_avgTxt
        minimumRangeValue: MyGlobal.flowDial_minimumRangeValue
        maximumRangeValue: MyGlobal.flowDial_maximumRangeValue
        warningValueLow: MyGlobal.flowDial_warningValueLow
        errorValueLow: MyGlobal.flowDial_errorValueLow
        warningValueHigh: MyGlobal.flowDial_warningValueHigh
        errorValueHigh: MyGlobal.flowDial_errorValueHigh

        barWidth: MyStyle.dialBarWidth
        ticksOn: MyStyle.dialTicksOn

        Connections {
          target: MyGlobal
          onFlowDial_currentValueChanged: {
            flowDial.currentValue = MyGlobal.flowDial_currentValue
            flowDial.barWidth = flowDial.barWidth - 5
            console.log("Width == ", flowDial.barWidth)
          }
        }

        Connections {
          target: MyGlobal
          onFlowDial_measuredMaxValueChanged: {
            flowDial.measuredMaxValue = MyGlobal.flowDial_measuredMaxValue
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_maxTxtChanged: {
            flowDial.maxTxt = MyGlobal.flowDial_maxTxt
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_measuredAvgValueChanged: {
            flowDial.measuredAvgValue = MyGlobal.flowDial_measuredAvgValue
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_avgTxtValueChanged: {
            flowDial.avgTxt = MyGlobal.flowDial_avgTxt
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_minimumRangeValueChanged: {
            flowDial.minimumRangeValue = MyGlobal.flowDial_minimumRangeValue
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_maximumRangeValueChanged: {
            flowDial.maximumRangeValue = MyGlobal.flowDial_maximumRangeValue
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_warningValueLowChanged: {
            flowDial.warningValueLow = MyGlobal.flowDial_warningValueLow
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_errorValueLowChanged: {
            flowDial.errorValueLow = MyGlobal.flowDial_errorValueLow
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_warningValueHighChanged: {
            flowDial.warningValueHigh = MyGlobal.flowDial_warningValueHigh
          }
        }
        Connections {
          target: MyGlobal
          onFlowDial_errorValueHighChanged: {
            flowDial.errorValueHigh = MyGlobal.flowDial_errorValueHigh
          }
        }

        Connections {
          target: MyStyle
          onDialBarWidthChanged: {
            flowDial.barWidth = MyStyle.dialBarWidth
          }
        }

        Connections {
          target: MyStyle
          onDialTicksOnChanged: {
            flowDial.ticksOn = MyStyle.dialTicksOn
          }
        }

      }

      C_SpeedDial {
        objectName: "fuelDial"
        id: fuelDial
        legendTxt: "Fuel"
        units: "L/Hr"
        state: 0

        Layout.row: 0
        Layout.column: 1
        Layout.alignment: Qt.AlignHCenter

        currentValue: MyGlobal.fuelDial_currentValue
        measuredMaxValue: MyGlobal.fuelDial_measuredMaxValue
        maxTxt: MyGlobal.fuelDial_maxTxt
        measuredAvgValue: MyGlobal.fuelDial_measuredAvgValue
        avgTxt: MyGlobal.fuelDial_avgTxt
        minimumRangeValue: MyGlobal.fuelDial_minimumRangeValue
        maximumRangeValue: MyGlobal.fuelDial_maximumRangeValue
        warningValueLow: MyGlobal.fuelDial_warningValueLow
        errorValueLow: MyGlobal.fuelDial_errorValueLow
        warningValueHigh: MyGlobal.fuelDial_warningValueHigh
        errorValueHigh: MyGlobal.fuelDial_errorValueHigh
        barWidth: MyStyle.dialBarWidth
        ticksOn: MyStyle.dialTicksOn

        Connections {
          target: MyStyle
          onDialBarWidthChanged: {
            fuelDial.barWidth = MyStyle.dialBarWidth
          }
        }

        Connections {
          target: MyStyle
          onDialTicksOnChanged: {
            fuelDial.ticksOn = MyStyle.dialTicksOn
          }
        }

        Connections {
          target: MyGlobal
          onFuelDial_currentValueChanged: {
            fuelDial.currentValue = MyGlobal.fuelDial_currentValue
            fuelDial.barWidth = fuelDial.barWidth - 5
            console.log("Width == ", fuelDial.barWidth)
          }
        }

        Connections {
          target: MyGlobal
          onFuelDial_measuredMaxValueChanged: {
            fuelDial.measuredMaxValue = MyGlobal.fuelDial_measuredMaxValue
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_maxTxtChanged: {
            fuelDial.maxTxt = MyGlobal.fuelDial_maxTxt
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_measuredAvgValueChanged: {
            fuelDial.measuredAvgValue = MyGlobal.fuelDial_measuredAvgValue
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_avgTxtValueChanged: {
            fuelDial.avgTxt = MyGlobal.fuelDial_avgTxt
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_minimumRangeValueChanged: {
            fuelDial.minimumRangeValue = MyGlobal.fuelDial_minimumRangeValue
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_maximumRangeValueChanged: {
            fuelDial.maximumRangeValue = MyGlobal.fuelDial_maximumRangeValue
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_warningValueLowChanged: {
            fuelDial.warningValueLow = MyGlobal.fuelDial_warningValueLow
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_errorValueLowChanged: {
            fuelDial.errorValueLow = MyGlobal.fuelDial_errorValueLow
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_warningValueHighChanged: {
            fuelDial.warningValueHigh = MyGlobal.fuelDial_warningValueHigh
          }
        }
        Connections {
          target: MyGlobal
          onFuelDial_errorValueHighChanged: {
            fuelDial.errorValueHigh = MyGlobal.fuelDial_errorValueHigh
          }
        }

        Connections {
          target: MyStyle
          onDialBarWidthChanged: {
            fuelDial.barWidth = MyStyle.dialBarWidth
          }
        }

        Connections {
          target: MyStyle
          onDialTicksOnChanged: {
            FuelDial.ticksOn = MyStyle.dialTicksOn
          }
        }


      }

      C_SpeedDial {
        objectName: "airDial"
        id: airDial
        legendTxt: "AirFl"
        units: MyStyle.metricStr //"PSI"
        state: 0

        Layout.row: 0
        Layout.column: 2
        Layout.alignment: Qt.AlignHCenter

        currentValue: MyGlobal.airDial_currentValue
        measuredMaxValue: MyGlobal.airDial_measuredMaxValue
        maxTxt: MyGlobal.airDial_maxTxt
        measuredAvgValue: MyGlobal.airDial_measuredAvgValue
        avgTxt: MyGlobal.airDial_avgTxt
        minimumRangeValue: MyGlobal.airDial_minimumRangeValue
        maximumRangeValue: MyGlobal.airDial_maximumRangeValue
        warningValueLow: MyGlobal.airDial_warningValueLow
        errorValueLow: MyGlobal.airDial_errorValueLow
        warningValueHigh: MyGlobal.airDial_warningValueHigh
        errorValueHigh: MyGlobal.airDial_errorValueHigh
        barWidth: MyStyle.dialBarWidth
        ticksOn: MyStyle.dialTicksOn

        Connections {
          target: MyStyle
          onDialBarWidthChanged: {
            airDial.barWidth = MyStyle.dialBarWidth
          }
        }

        Connections {
          target: MyStyle
          onDialTicksOnChanged: {
            airDial.ticksOn = MyStyle.dialTicksOn
          }
        }

        Connections {
          target: MyGlobal
          onAirDial_currentValueChanged: {
            airDial.currentValue = MyGlobal.airDial_currentValue
            airDial.barWidth = airDial.barWidth - 5
            console.log("Width == ", airDial.barWidth)
          }
        }

        Connections {
          target: MyGlobal
          onAirDial_measuredMaxValueChanged: {
            airDial.measuredMaxValue = MyGlobal.airDial_measuredMaxValue
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_maxTxtChanged: {
            airDial.maxTxt = MyGlobal.airDial_maxTxt
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_measuredAvgValueChanged: {
            airDial.measuredAvgValue = MyGlobal.airDial_measuredAvgValue
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_avgTxtValueChanged: {
            airDial.avgTxt = MyGlobal.airDial_avgTxt
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_minimumRangeValueChanged: {
            airDial.minimumRangeValue = MyGlobal.airDial_minimumRangeValue
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_maximumRangeValueChanged: {
            airDial.maximumRangeValue = MyGlobal.airDial_maximumRangeValue
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_warningValueLowChanged: {
            airDial.warningValueLow = MyGlobal.fuelDial_warningValueLow
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_errorValueLowChanged: {
            airDial.errorValueLow = MyGlobal.airDial_errorValueLow
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_warningValueHighChanged: {
            airDial.warningValueHigh = MyGlobal.airDial_warningValueHigh
          }
        }
        Connections {
          target: MyGlobal
          onAirDial_errorValueHighChanged: {
            airDial.errorValueHigh = MyGlobal.airDial_errorValueHigh
          }
        }

        Connections {
          target: MyStyle
          onDialBarWidthChanged: {
            airDial.barWidth = MyStyle.dialBarWidth
          }
        }

        Connections {
          target: MyStyle
          onDialTicksOnChanged: {
            airDial.ticksOn = MyStyle.dialTicksOn
          }
        }

      }

      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      Comp {
        id: c_Engine2
        c_objectName: "c_Engine"
        c_value: 127
        c_measure: qsTr(" rpm")
        c_srcName: "Images/engine.png"
        Layout.row: 1
        Layout.column: 0
        Layout.alignment: Qt.AlignHCenter

        Connections {
          target: MyGlobal
          onEngineRPMStateChanged: {
            c_Engine2.c_state = MyGlobal.engineRPMState
            //console.log("engineRPMState changed = ", MyGlobal.engineRPMState, " ", c_Engine2.c_state)
            computePageStatus_Engine()
          }
        }

        Connections {
          target: MyGlobal
          onEngineRPMValueChanged: {
            c_Engine2.c_value = MyGlobal.engineRPMValue
          }
        }

        Connections {
          target: MyGlobal
          onEngineRPMSrcNameChanged: {
            c_Engine2.c_srcName = MyGlobal.engineRPMSrcName
          }
        }

        Connections {
          target: MyGlobal
          onEngineRPMMeasureChanged: {
            c_Engine2.c_measure = MyGlobal.engineRPMMeasure
          }
        }

      }

      Comp {
        id: c_Aerator
        c_objectName: "c_Aerator"
        c_value: airDial.currentValue
        c_measure: airDial.units
        c_srcName: "Images/bubbles_100x100.png"
        c_state: airDial.state
        //anchors.horizontalCenter: myDial1.horizontalCenter
        Layout.row: 1
        Layout.column: 2
        Layout.alignment: Qt.AlignHCenter
        onClicked: {
          console.log("clicked " + c_objectName + " " + c_state)
          MyGlobal.stateAerator = c_state
          computePageStatus_Aerator()
        }

        Connections {
          target: MyGlobal
          onAeratorStateChanged: {
            c_Aerator.c_state = MyGlobal.aeratorState
          }
        }

        Connections {
          target: MyGlobal
          onAeratorValueChanged: {
            c_Aerator.c_value = MyGlobal.aeratorValue
          }
        }

        Connections {
          target: MyGlobal
          onAeratorSrcNameChanged: {
            c_Aerator.c_srcName = MyGlobal.aeratorSrcName
          }
        }

        Connections {
          target: MyGlobal
          onAeratorMeasureChanged: {
            c_Aerator.c_measure = MyGlobal.aeratorMeasure
          }
        }
      }

      Comp {
        id: c_Fuel
        c_objectName: "c_Fuel"
        c_value: 57
        c_measure: qsTr("%")
        c_srcName: "Images/fuel.png"

        Layout.row: 1
        Layout.column: 1
        Layout.alignment: Qt.AlignHCenter

        onClicked: {
          console.log("clicked " + c_objectName + " " + c_state)
          MyGlobal.stateFuel = c_state
          computePageStatus_Engine()
        }

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

    }
  }
}
