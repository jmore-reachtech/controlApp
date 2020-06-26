#include "myGlobal.h"
#include <QDebug>

GlobalValues::GlobalValues(QObject * parent): QQmlPropertyMap(this, parent) {
  setObjectName("global");

  insert("aeratorValue", 66.0);
  insert("aeratorState", 1);
  insert("aeratorMeasure", " psi");
  insert("aeratorSrcName", "Images/bubbles_100x100.png");
  insert("batteryValue", 14.8);
  insert("batteryState", 0);
  insert("batteryMeasure", "Vdc");
  insert("batterySrcName", "Images/battery.png");
  insert("coolantTempValue", 190.0);
  insert("coolantTempState", 0);
  insert("coolantTempMeasure", "°C");
  insert("coolantTempSrcName", "Images/coolant.png");
  insert("engineTempValue", 241.0);
  insert("engineTempState", 0);
  insert("engineTempMeasure", "°C");
  insert("engineTempSrcName", "Images/liquid_temperature.png");
  insert("fuelValue", 56.0);
  insert("fuelState", 0);
  insert("fuelMeasure", "%");
  insert("fuelSrcName", "Images/fuel.png");
  insert("oilValue", 40.0);
  insert("oilState", 0);
  insert("oilMeasure", "psi");
  insert("oilSrcName", "Images/oil.png");
  insert("vACValue", 347.0);
  insert("vACState", 0);
  insert("vACMeasure", "Vac");
  insert("vACSrcName", "Images/ac.png");
  insert("vDCValue", 47.8);
  insert("vDCState", 2);
  insert("vDCMeasure", "Vdc");
  insert("vDCSrcName", "/Images/dc.png");


  //engineRPM
  insert("engineRPMValue", 2184.0);
  insert("engineRPMState", 0);
  insert("engineRPMMeasure", "RPM");
  insert("engineRPMSrcName", "Images/engine.png");
  insert("engineRPMmeasuredMaxValue", 2222);
  insert("engineRPMmaxTxt", "MAX");
  insert("engineRPMmeasuredAvgValue", 1280);
  insert("engineRPMavgTxt", "AVG");
  insert("engineRPMminimumRangeValue", 0);
  insert("engineRPMmaximumRangeValue", 5000);
  insert("engineRPMwarningValueLow", 400);
  insert("engineRPMerrorValueLow", 300);
  insert("engineRPMwarningValueHigh", 4000);
  insert("engineRPMerrorValueHigh", 4500);
  insert("engineRPMbarWidth", 15);
  //insert("engineRPM_ticksOn", false);




  //flowDial
  insert("flowDial_currentValue", 100);
  insert("flowDial_measuredMaxValue", 111);
  insert("flowDial_maxTxt", "MAX");
  insert("flowDial_measuredAvgValue", 98);
  insert("flowDial_avgTxt", "AVG");
  insert("flowDial_minimumRangeValue", 10);
  insert("flowDial_maximumRangeValue", 200);
  insert("flowDial_warningValueLow", 40);
  insert("flowDial_errorValueLow", 20);
  insert("flowDial_warningValueHigh", 160);
  insert("flowDial_errorValueHigh", 180);
  insert("flowDial_barWidth", 15);
  //insert("flowDial_ticksOn", false);

  //fuelDial
  insert("fuelDial_currentValue", 15);
  insert("fuelDial_measuredMaxValue", 19);
  insert("fuelDial_maxTxt", "MAX");
  insert("fuelDial_measuredAvgValue", 12);
  insert("fuelDial_avgTxt", "AVG");
  insert("fuelDial_minimumRangeValue", 0);
  insert("fuelDial_maximumRangeValue", 60);
  insert("fuelDial_warningValueLow", 8);
  insert("fuelDial_errorValueLow", 5);
  insert("fuelDial_warningValueHigh", 45);
  insert("fuelDial_errorValueHigh", 55);
  insert("fuelDial_barWidth", 15);
 // insert("fuelDial_ticksOn", true);

  //airDial
  insert("airDial_currentValue", 66);
  insert("airDial_measuredMaxValue", 62);
  insert("airDial_maxTxt", "MAX");
  insert("airDial_measuredAvgValue", 59);
  insert("airDial_avgTxt", "AVG");
  insert("airDial_minimumRangeValue", 0);
  insert("airDial_maximumRangeValue", 100);
  insert("airDial_warningValueLow", 20);
  insert("airDial_errorValueLow", 10);
  insert("airDial_warningValueHigh", 75);
  insert("airDial_errorValueHigh", 90);
  insert("airDial_barWidth", 15);
 // insert("airDial_ticksOn", false);

}

void GlobalValues::startEngine() {
  qDebug() << "Start ENGINE GLOBAL " << Q_FUNC_INFO;
}
