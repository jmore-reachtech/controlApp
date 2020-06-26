import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "."

Page {
  id: aeratorPage
  title: qsTr("Aerator Status")

  property int state: 3

  width: MyStyle.panelWidth
  height: MyStyle.panelHeight

  //needed to restore the values of the components when Drawer re-inits the page
  onFocusChanged: {
    c_Aerator.c_state = MyGlobal.aeratorState
    c_Aerator.c_value = MyGlobal.aeratorValue
    c_Aerator.c_measure = MyGlobal.aeratorMeasure
    c_Aerator.c_srcName = MyGlobal.aeratorSrcName
  }

  Component.onCompleted: {
    console.log("Aerator LOADED")
    drawState++
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
      id: c_Aerator
      c_objectName: "c_Aerator"
      c_value: qsTr("37")
      c_measure: qsTr(" psi")
      c_srcName: "Images/bubbles_100x100.png"

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
  }
}