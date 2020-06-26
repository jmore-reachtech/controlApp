import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import QtGraphicalEffects 1.0
import "."

Rectangle {
    id: gauge
    property alias state: canvas.state
    property alias currentValue: canvas.currentValue
    property alias measuredMaxValue: canvas.measuredMaxValue
    property alias measuredAvgValue: canvas.measuredAvgValue
    property alias minimumRangeValue: canvas.minimumRangeValue
    property alias maximumRangeValue: canvas.maximumRangeValue

    property alias warningValueHigh: canvas.warningValueHigh
    property alias errorValueHigh: canvas.errorValueHigh
    property alias warningValueLow: canvas.warningValueLow
    property alias errorValueLow: canvas.errorValueLow
    property alias ticksOn: canvas.ticks
    property alias primaryColor: canvas.secondaryColor
    property alias secondaryColor: canvas.primaryColor
    property alias barWidth: canvas.barWidth

    property alias legendTxt: canvas.legendStr
    property alias units: metric.text
    property alias maxTxt: max.text
    property alias avgTxt: avg.text

    border.width: MyStyle.borderWidth
    border.color: MyStyle.borderColor
    height: MyStyle.dialHeight
    width: MyStyle.dialWidth
    color: MyStyle.backColor

  Canvas {
    id: canvas
    height: gauge.height
    width: gauge.width
    antialiasing: true
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }

    property real barWidth: MyStyle.dialBarWidth
    property color primaryColor: "grey"
    property color secondaryColor: "white"

    property int centerOffset: centerWidth - width / 2
    property int centerWidth: width * .64
    property real centerHeight: height / 2

    property int arcWidth: height / 20
    property real radius: Math.min(width, height) / 2
    property real angle: (currentValue - minimumRangeValue) / (maximumRangeValue - minimumRangeValue) * Math.PI
    property real angleOffset: Math.PI / 2

    property string legendStr: "boop"
    property int state: 0
    property real currentValue: 66
    property real measuredMaxValue: 98
    property real measuredAvgValue: 62
    property real minimumRangeValue: 0
    property real maximumRangeValue: 100

    property real warningValueLow: 60
    property real errorValueLow: 80
    property real warningValueHigh: 60
    property real errorValueHigh: 80
    property bool ticks: myStyle.dialTicksOn

    signal clicked()

    onPrimaryColorChanged: requestPaint()
    onSecondaryColorChanged: requestPaint()
    onMinimumRangeValueChanged: requestPaint()
    onMaximumRangeValueChanged: requestPaint()
    onMeasuredMaxValueChanged: requestPaint()
    onMeasuredAvgValueChanged: requestPaint()
    onCurrentValueChanged: requestPaint()
    onBarWidthChanged: requestPaint()

    onPaint: {
      var ctx = getContext("2d");
      var barColor;
      var myAngle;
      ctx.save();
      ctx.clearRect(0, 0, width, height);

      // First, thinner arc From angle to PI
      ctx.beginPath();
      ctx.lineWidth = barWidth;
      ctx.strokeStyle = primaryColor;
      ctx.arc(canvas.centerWidth,
        canvas.centerHeight,
        canvas.radius,
        angleOffset + canvas.angle,
        angleOffset + Math.PI,
        false);
      ctx.stroke();

      // Second, thicker arc - from 0 to angle
      ctx.beginPath();
      ctx.lineWidth = barWidth;

      barColor = MyStyle.clrOff; //oFF

      if (currentValue < minimumRangeValue) {
        currentValue = minimumRangeValue;
      }
      if (currentValue > maximumRangeValue) {
        currentValue = maximumRangeValue;
      }

      if (currentValue >= minimumRangeValue && currentValue <= maximumRangeValue) {
        barColor = MyStyle.clrNormal; //oN/Normal
        state = 1;
      }

      if (warningValueHigh < maximumRangeValue && currentValue > warningValueHigh) {
        barColor = MyStyle.clrWarning //warnHigh
        state = 2;
      }

      if (warningValueLow > minimumRangeValue && currentValue < warningValueLow) {
        barColor = MyStyle.clrWarning //warnLow
        state = 2;
      }

      if (errorValueHigh < maximumRangeValue && currentValue > errorValueHigh) {
        barColor = MyStyle.clrError //errHigh
        state = 3;
      }

      if (errorValueLow > minimumRangeValue && currentValue < errorValueLow) {
        barColor = MyStyle.clrError //errLow
        state = 3;
      }

      ctx.strokeStyle = barColor;
      ctx.arc(canvas.centerWidth,
        canvas.centerHeight,
        canvas.radius,
        canvas.angleOffset,
        canvas.angleOffset + canvas.angle,
        false);
      ctx.stroke();

      // fills the mouse area when pressed
      // the fill color is a lighter version of the secondary color
      if (mouseArea.pressed) {
        ctx.beginPath();
        ctx.lineWidth = barWidth + 2;
        ctx.strokeStyle = Qt.lighter(barColor, 1.25);
        ctx.arc(canvas.centerWidth,
          canvas.centerHeight,
          canvas.radius,
          canvas.angleOffset,
          canvas.angleOffset + canvas.angle,
          false);
        ctx.stroke();
      }

      if (ticks) {
        //set the warningValueHigh tick
        if (warningValueHigh < maximumRangeValue) {
          myAngle = (warningValueHigh - minimumRangeValue) / (maximumRangeValue - minimumRangeValue) * Math.PI
          ctx.beginPath();
          ctx.lineWidth = barWidth + 5;
          ctx.strokeStyle = MyStyle.clrWarning;
          ctx.arc(canvas.centerWidth,
            canvas.centerHeight,
            canvas.radius,
            canvas.angleOffset + myAngle, // -  0.0174533,
            canvas.angleOffset + myAngle + 0.0174533,
            false);
          ctx.stroke();
        }

        //set the warningValueLow tick
        if (warningValueLow > minimumRangeValue) {
          myAngle = (warningValueLow - minimumRangeValue) / (maximumRangeValue - minimumRangeValue) * Math.PI
          ctx.beginPath();
          ctx.lineWidth = barWidth + 5;
          ctx.strokeStyle = MyStyle.clrWarning;
          ctx.arc(canvas.centerWidth,
            canvas.centerHeight,
            canvas.radius,
            canvas.angleOffset + myAngle - 0.0174533,
            canvas.angleOffset + myAngle, // +  0.0174533,
            false);
          ctx.stroke();
        }

        //set the errorValueHigh tick
        if (errorValueHigh < maximumRangeValue) {
          myAngle = (errorValueHigh - minimumRangeValue) / (maximumRangeValue - minimumRangeValue) * Math.PI
          ctx.beginPath();
          ctx.lineWidth = barWidth + 5;
          ctx.strokeStyle = MyStyle.clrError;
          ctx.arc(canvas.centerWidth,
            canvas.centerHeight,
            canvas.radius,
            canvas.angleOffset + myAngle, // -  0.0174533,
            canvas.angleOffset + myAngle + 0.0174533,
            false);
          ctx.stroke();
        }

        //set the warningValueLow tick
        if (errorValueLow > minimumRangeValue) {
          myAngle = (errorValueLow - minimumRangeValue) / (maximumRangeValue - minimumRangeValue) * Math.PI
          ctx.beginPath();
          ctx.lineWidth = barWidth + 5;
          ctx.strokeStyle = MyStyle.clrError;
          ctx.arc(canvas.centerWidth,
            canvas.centerHeight,
            canvas.radius,
            canvas.angleOffset + myAngle - 0.0174533,
            canvas.angleOffset + myAngle, // +  0.0174533,
            false);
          ctx.stroke();
        }
      }

      // Set the needle
      ctx.beginPath();
      ctx.lineWidth = barWidth + 5;
      ctx.strokeStyle = "white";
      ctx.arc(canvas.centerWidth,
        canvas.centerHeight,
        canvas.radius,
        canvas.angleOffset + canvas.angle - 0.0349066, //0.0174533,
        canvas.angleOffset + canvas.angle + 0.0349066, //0.0174533,
        false);
      ctx.stroke();

      ctx.restore();
    } //onPaint
  } //Canvas

  Text {
    id: descript
    anchors {
      horizontalCenter: parent.horizontalCenter
      horizontalCenterOffset: 20
      bottom: parent.verticalCenter
      bottomMargin: 5
      //.centerIn: parent
    }
    text: canvas.legendStr
    color: MyStyle.textColor
    font.pixelSize: gauge.height / 7
  }

  Text {
    id: val
    anchors {
      horizontalCenter: descript.horizontalCenter
      top: descript.bottom
    }
    text: gauge.currentValue
    color: MyStyle.textColor
    font.pixelSize: descript.font.pixelSize * 0.8
  }

  Text {
    id: metric
    anchors {
      horizontalCenter: descript.horizontalCenter
      top: val.bottom
    }
    text: "SCFM"
    color: MyStyle.textColor
    font.pixelSize: descript.font.pixelSize * 0.6
  }

  // MAX AND MIN
  Text {
    id: maxVal
    anchors {
      left: descript.horizontalCenter
      leftMargin: 10
      top: gauge.top
      topMargin: 12
    }
    text: gauge.maximumRangeValue
    color: MyStyle.textColor
    font.pixelSize: gauge.height / 14
  }

  Text {
    id: minVal
    anchors {
      left: descript.horizontalCenter
      leftMargin: 10
      bottom: gauge.bottom
      bottomMargin: 14
    }
    text: gauge.minimumRangeValue
    color: MyStyle.textColor
    font.pixelSize: gauge.height / 14
  }

  // Measured MAX AND AVG
  Text {
    id: measuredMaxVal
    anchors {
      left: gauge.left
      leftMargin: 5
      top: gauge.top
      topMargin: 5
    }
    text: gauge.measuredMaxValue
    color: MyStyle.textColor
    font.pixelSize: gauge.height / 12
  }

  Text {
    id: max
    anchors {
      horizontalCenter: measuredMaxVal.horizontalCenter
      top: measuredMaxVal.bottom
    }
    text: "MAX"
    color: MyStyle.textColor
    font.pixelSize: gauge.height / 24
  }

  Text {
    id: measuredAvgVal
    anchors {
      horizontalCenter: measuredMaxVal.horizontalCenter
      bottom: avg.top
    }
    text: canvas.measuredAvgValue
    color: MyStyle.textColor
    font.pixelSize: gauge.height / 12
  }

  Text {
    id: avg
    anchors {
      horizontalCenter: measuredMaxVal.horizontalCenter
      bottom: gauge.bottom
      bottomMargin: 5
    }
    text: "AVG"
    color: MyStyle.textColor
    font.pixelSize: gauge.height / 24
  }

//MOUSE
MouseArea {
  id: mouseArea
  anchors.fill: parent
//      onClicked: {
//        ticks: canvas.ticks ? (canvas.ticks = false) : (canvas.ticks = true)
//        canvas.clicked()
//      }
  onPressed: {
    console.log("Mouse pressed " + gauge.objectName)
    canvas.requestPaint()
  }
  onReleased: {
    console.log("Mouse released " + gauge.objectName)
    canvas.requestPaint()
  }
} //MouseArea

}
