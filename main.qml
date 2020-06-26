import QtQuick 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

import "."

ApplicationWindow {
  id: window
  objectName: "window"
  visible: true

  width: MyStyle.panelWidth
  height: MyStyle.panelHeight
  color: MyStyle.backColor

  signal submitTextField(string text)

//  property int foo: 0
  //property alias homePage: homePage


  ///EnginePage ////////////////////////////////////////////////////////////////////////////////////////////////////
  //**** Do not change directly
  property int engineStatus: 0
  property string engineStatusColor: MyStyle.clrWarning

  //OK to change
  property string drwrEngine: qsTr("Engine Status")

  onEngineStatusChanged: {
    //console.log("Engine Status change!")
    computePageStatus_Engine()
    computePageStatus_Generator()
    computePageStatus_Aerator()
  }

  function computePageStatus_Engine() {
    var myRet = MyGlobal.engineRPMState

    if (myRet < MyGlobal.fuelState) {
      myRet = MyGlobal.fuelState
    }

    if (myRet < MyGlobal.oilState) {
      myRet = MyGlobal.oilState
    }

    if (myRet < MyGlobal.engineTempState) {
      myRet = MyGlobal.engineTempState
    }

    if (myRet < MyGlobal.batteryState) {
      myRet = MyGlobal.batteryState
    }

    if (myRet < MyGlobal.coolantTempState) {
      myRet = MyGlobal.coolantTempState
    }

    if (myRet > 4) myRet = 4
    if (myRet < 0) myRet = 0

    if      (myRet === 0) window.engineStatusColor = MyStyle.clrOff
    else if (myRet === 1) window.engineStatusColor = MyStyle.clrNormal
    else if (myRet === 2) window.engineStatusColor = MyStyle.clrWarning
    else if (myRet === 3) window.engineStatusColor = MyStyle.clrFault
    else if (myRet === 4) window.engineStatusColor = MyStyle.clrError

    window.engineStatus = ~~myRet //convert float to int by bit inverting twice.
    getAggStatus()
  }

  ///GeneratorPage ////////////////////////////////////////////////////////////////////////////////////////////////////
  //**** Do not change directly
  property int generatorStatus: 0
  property string generatorStatusColor: MyStyle.clrWarning

  //OK to change
  property string drwrGenerator: qsTr("Generator Status")

  onGeneratorStatusChanged: {
    computePageStatus_Engine()
    computePageStatus_Generator()
    computePageStatus_Aerator()
  }

  function computePageStatus_Generator() {
    var ret = MyGlobal.vACState
    if (ret < MyGlobal.vDCState) {
      ret = MyGlobal.vDCState
    }

    if (ret > 4) ret = 4
    if (ret < 0) ret = 0

    if (ret === 0) window.generatorStatusColor = MyStyle.clrOff
    else if (ret === 1) window.generatorStatusColor = MyStyle.clrNormal
    else if (ret === 2) window.generatorStatusColor = MyStyle.clrWarning
    else if (ret === 3) window.generatorStatusColor = MyStyle.clrFault
    else if (ret === 4) window.generatorStatusColor = MyStyle.clrError

    window.generatorStatus = ret
    getAggStatus()
  }

  ///AeratorPage ////////////////////////////////////////////////////////////////////////////////////////////////////
  //**** Do not change directly
  property int aeratorStatus: 0
  property string aeratorStatusColor: MyStyle.clrOff

  //OK to change
  property string drwrAerator: qsTr("Aerator Status")

  onAeratorStatusChanged: {
    console.log("Aerator Status change!")
    computePageStatus_Engine()
    computePageStatus_Generator()
    computePageStatus_Aerator()
  }

  function computePageStatus_Aerator() {
    var ret = MyGlobal.aeratorState
    if (ret > 4) ret = 4
    if (ret < 0) ret = 0

    if (ret === 0) window.aeratorStatusColor = MyStyle.clrOff
    else if (ret === 1) window.aeratorStatusColor = MyStyle.clrNormal
    else if (ret === 2) window.aeratorStatusColor = MyStyle.clrWarning
    else if (ret === 3) window.aeratorStatusColor = MyStyle.clrFault
    else if (ret === 4) window.aeratorStatusColor = MyStyle.clrError

    MyGlobal.aeratorState = ret
    getAggStatus()
  }

  ///Aggregated Status ////////////////////////////////////////////////////////////////////////////////////////////////////
  property int drawState: 0

  onDrawStateChanged: {
    console.log(" -- Draw Change -- ")
    computePageStatus_Engine()
    computePageStatus_Generator()
    computePageStatus_Aerator()
  }

  ///Aggregated Condition Data
  //**** Do not change directly
  property int aggregatedStatus: 0
  property string aggregatedStatusColor: MyStyle.clrOff

  function getAggStatus() {
    window.aggregatedStatus = 0
    var ret = window.engineStatus
    window.aggregatedStatusColor = MyStyle.clrOff
    if (window.generatorStatus > window.engineStatus) ret = window.generatorStatus
    if (window.aeratorStatus > window.generatorStatus) ret = window.aeratorStatus
    window.aggregatedStatus = ret

    //ret has the highest value
    var str = MyStyle.strOff
    if (window.aggregatedStatus === 0) {
      str = MyStyle.strOff
      window.aggregatedStatusColor = MyStyle.clrOff
      imgState.source = MyStyle.imgOff
    } else if (aggregatedStatus === 1) {
      str = MyStyle.strNormal
      window.aggregatedStatusColor = MyStyle.clrNormal
      imgState.source = MyStyle.imgNormal
    } else if (window.aggregatedStatus === 2) {
      str = MyStyle.strWarning
      window.aggregatedStatusColor = MyStyle.clrWarning
      imgState.source = MyStyle.imgWarning
    } else if (window.aggregatedStatus === 3) {
      str = MyStyle.strFault
      window.aggregatedStatusColor = MyStyle.clrFault
      imgState.source = MyStyle.imgFault
    } else if (window.aggregatedStatus === 4) {
      str = MyStyle.strError
      window.aggregatedStatusColor = MyStyle.clrError
      imgState.source = MyStyle.imgError
    }
    systemState.text = str
    systemState.color = MyStyle.statusTextColor
  }


  SwipeView {
      id: view
      currentIndex: 0
      anchors.fill: parent

      function addPage(page) {
          addItem(page)
          page.visible = true
      }

      function removePage(page) {
          for (var n = 0; n < count; n++) { if (page === itemAt(n)) { removeItem(n) } }
          page.visible = false
      }

      P_Home {
          id: firstpage
          objectName: "Home"
      }
      P_Engine {
          id: secondpage
          objectName: "Engine"
      }
      P_Generator {
          id: thirdpage
          objectName: "Generator"
      }
      P_Aerator {
          id: fourthpage
          objectName: "Aerator"
      }
  }


  Page {
      id: page1
      visible: false;
      background: Rectangle { color: "yellow" }
      Label {
          text: "Page1"
      }
  }

  Page {
      id: page2
      visible: false;
      background: Rectangle { color: "lightGreen" }
      Label {
          text: "Page2"
      }
  }

  Page {
      id: page3
      visible: false;
      background: Rectangle { color: "magenta" }
      Label {
          text: "Page3"
      }
  }

  /*
  SwipeView {
      id: swipeView
      Repeater {
          model: 3
          Loader {
              active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
              sourceComponent: Text {
                  text: "foo " + index + "  "
                  Component.onCompleted: console.log("created:", index)
                  Component.onDestruction: console.log("destroyed:", index)
              }
          }
      }
  }
*/


  title: qsTr("Reach Technology Demo")

  header: ToolBar {
    id: tools
    Rectangle {
      id: statRow

      anchors.fill: parent
      width: parent.width
      height: MyStyle.statusBarHeight
      anchors.top: parent.top
      border.width: MyStyle.borderWidth
      border.color: MyStyle.borderColor
      color: MyStyle.statusBackColor

      PageIndicator {
          id: indicator

          count: view.count
          currentIndex: view.currentIndex

          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
      }

      Label {
        id: lblCtr
        Text {
          color: "black" //MyStyle.statusTextColor
          text: view.currentItem.objectName
          font.pixelSize: 16
        }
        anchors {
          left: indicator.right
          leftMargin: 10
          verticalCenter: parent.verticalCenter
        }
        MouseArea {

        }
      }

/*
      Button {
        id: toolButton
        //enabled: index < delegate.SwipeView.view.count - 1
        text: "<>UP"
        //font.pixelSize: Qt.application.font.pixelSize * 1.6
        anchors {
            left: lblCtr.right
            leftMargin: 40
        }
        onClicked: {
            console.log("Up")
            //view.incrementCurrentIndex()
        }
      }
*/

      Image {
        id: imgState
        source: MyStyle.imgOff
        height: 30
        fillMode: Image.PreserveAspectFit
        anchors {
          left: lblCtr.right
          leftMargin: 150
          verticalCenter: parent.verticalCenter
        }
      }

      Label {
        id: systemState
        Text {
          text: "" //MyStyle.strOff
          font.pixelSize: 12
          color: MyStyle.statusTextColor
        }
        anchors {
          verticalCenter: parent.verticalCenter
          left: imgState.right
          leftMargin: 10
        }

      }

      Image {
        id: logo
        source: MyStyle.imgLogo
        height: 30
        fillMode: Image.PreserveAspectFit
        anchors {
          right: parent.right;
          rightMargin: 10
          verticalCenter: parent.verticalCenter;
        }
      }
    }
  } //end Toolbar


  //Connections
  Connections {
    target: MyGlobal
    onEngineRPMStateChanged: {
      computePageStatus_Engine()
    }
  }

  Connections {
    target: MyGlobal
    onFuelStateChanged: {
      computePageStatus_Engine()
    }
  }

  Connections {
    target: MyGlobal
    onOilStateChanged: {
      computePageStatus_Engine()
    }
  }

  Connections {
    target: MyGlobal
    onEngineTempStateChanged: {
      computePageStatus_Engine()
    }
  }

  Connections {
    target: MyGlobal
    onBatteryStateChanged: {
      computePageStatus_Engine()
    }
  }

  Connections {
    target: MyGlobal
    onCoolantTempStateChanged: {
      computePageStatus_Engine()
    }
  }

  Connections {
    target: MyGlobal
    onVACStateChanged: {
      computePageStatus_Generator()
    }
  }

  Connections {
    target: MyGlobal
    onVDCStateChanged: {
      computePageStatus_Generator()
    }
  }

  Connections {
    target: MyGlobal
    onAeratorStateChanged: {
      computePageStatus_Aerator()
    }
  }

  Connections {
    target: MyStyle
    onThemeDarkChanged: {
      if (MyStyle.themeDark === true) {
//  console.debug("THEME DARK ")
        MyStyle.backColor = MyStyle.backColorDk
        MyStyle.statusBackColor = MyStyle.statusBackColorDk
        MyStyle.textColor = MyStyle.textColorDk
        MyStyle.statusTextColor = MyStyle.statusTextColorDk

        MyStyle.clrOff = MyStyle.clrOffDk
        MyStyle.clrNormal = MyStyle.clrNormalDk
        MyStyle.clrWarning = MyStyle.clrWarningDk
        MyStyle.clrFault = MyStyle.clrFaultDk
        MyStyle.clrError = MyStyle.clrErrorDk

      } else {
//  console.debug("THEME LIGHT ")
        MyStyle.backColor = MyStyle.backColorLt
        MyStyle.statusBackColor = MyStyle.statusBackColorLt
        MyStyle.textColor = MyStyle.textColorLt
        MyStyle.statusTextColor = MyStyle.statusTextColorLt

        MyStyle.clrOff = MyStyle.clrOffLt
        MyStyle.clrNormal = MyStyle.clrNormalLt
        MyStyle.clrWarning = MyStyle.clrWarningLt
        MyStyle.clrFault = MyStyle.clrFaultLt
        MyStyle.clrError = MyStyle.clrErrorLt

      }
    }
  }

  Connections {
    target: MyStyle
    onMetricBoolChanged: {
      if (MyStyle.metricBool) {
        //                console.log("CENTIGRADE")
        MyStyle.metricStr = MyStyle.centigradeStr
      } else {
        //                console.log("FAHRENHEIT")
        MyStyle.metricStr = MyStyle.fahrenheitStr
      }
    }
  }

}
