import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "."

Page {
  id: generatorPage
  title: qsTr("Generator Status")

  property int state: 3

  width: MyStyle.panelWidth
  height: MyStyle.panelHeight

  //needed to restore the values of the components when Drawer re-inits the page
  onFocusChanged: {
    c_AC.c_state = MyGlobal.vACState
    c_AC.c_value = MyGlobal.vACValue
    c_AC.c_measure = MyGlobal.vACMeasure
    c_AC.c_srcName = MyGlobal.vACSrcName

    c_DC.c_state = MyGlobal.vDCState
    c_DC.c_value = MyGlobal.vDCValue
    c_DC.c_measure = MyGlobal.vDCMeasure
    c_DC.c_srcName = MyGlobal.vDCSrcName
  }

  background: Rectangle {
    color: MyStyle.backColor
  }

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

    Comp {
      id: c_AC
      c_objectName: "c_AC"
      c_value: qsTr("347")
      c_measure: qsTr(" Vac")
      c_srcName: "Images/ac.png"

      Connections {
        target: MyGlobal
        onVACStateChanged: {
          c_AC.c_state = MyGlobal.vACState
        }
      }

      Connections {
        target: MyGlobal
        onVACValueChanged: {
          c_AC.c_value = MyGlobal.vACValue
        }
      }

      Connections {
        target: MyGlobal
        onVACSrcNameChanged: {
          c_AC.c_srcName = MyGlobal.vACSrcName
        }
      }

      Connections {
        target: MyGlobal
        onVACMeasureChanged: {
          c_AC.c_measure = MyGlobal.vACMeasure
        }
      }

    }

    Comp {
      id: c_DC
      c_objectName: "c_DC"
      c_value: qsTr("20")
      c_measure: qsTr(" Vdc")
      c_srcName: "Images/dc.png"

      Connections {
        target: MyGlobal
        onVDCStateChanged: {
          c_DC.c_state = MyGlobal.vDCState
        }
      }

      Connections {
        target: MyGlobal
        onVDCValueChanged: {
          c_DC.c_value = MyGlobal.vDCValue
        }
      }

      Connections {
        target: MyGlobal
        onVDCSrcNameChanged: {
          c_DC.c_srcName = MyGlobal.vDCSrcName
        }
      }

      Connections {
        target: MyGlobal
        onVDCMeasureChanged: {
          c_DC.c_measure = MyGlobal.vDCMeasure
        }
      }

    }

  }

}