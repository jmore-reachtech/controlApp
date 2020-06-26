#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QQmlContext>
#include <QDebug>

#include "qmldebugger.h"
#include "signal.h"
#include "common.h"
#include "mainviewcontroller.h"
#include "serialcontroller.h"
#include "translator.h"
#include "network.h"
#include "beeper.h"
#include "gpiopin.h"
#include "backlight.h"
#include "system.h"
#include "myStyle.h"
#include "myGlobal.h"
 //#include "json.h"

static void unixSignalHandler(int signum) {
  qDebug("[QML] main.cpp::unixSignalHandler(). signal = %s", strsignal(signum));
  qApp->exit(0);
}

StyleValues MyStyle;
GlobalValues MyGlobal;

int main(int argc, char * argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;

  engine.rootContext()->setContextProperty("MyStyle", & MyStyle);
  engine.rootContext()->setContextProperty("MyGlobal", & MyGlobal);

  qDebug() << "The style count is => " << MyStyle.count();
  qDebug() << "The global count is => " << MyGlobal.count();

  SerialController serialController;
  /* Need to register before the MainviewController is instantiated */
  qmlRegisterType < Network > ("net.reachtech", 1, 0, "Network");
  qmlRegisterType < Beeper > ("sound.reachtech", 1, 0, "Beeper");
  qmlRegisterType < GpioPin > ("gpio.reachtech", 1, 0, "GpioPin");
  qmlRegisterType < Backlight > ("backlight.reachtech", 1, 0, "Backlight");
  qmlRegisterType < System > ("system.reachtech", 1, 0, "System");
  qmlRegisterType < QMLDebugger > ("MyDemoLibrary", 1, 0, "QMLDebugger");

  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
  if (engine.rootObjects().isEmpty())
    return -1;

  QObject * topLevel = engine.rootObjects().value(0);
  QQuickWindow * window = qobject_cast < QQuickWindow * > (topLevel);
  if (window == nullptr) {
    qDebug() << "Can't instantiate window";
  }

  QObject::connect(window, SIGNAL(submitTextField(QString)), & serialController, SLOT(send(QString)));

  /* Set a signal handler for a power down or a control-c */
  if (signal(SIGTERM, unixSignalHandler) == SIG_ERR) {
    qDebug() << "[QML] an error occurred while setting the signal terminate handler";
  }
  if (signal(SIGINT, unixSignalHandler) == SIG_ERR) {
    qDebug() << "[QML] an error occurred while setting the signal interrupt handler";
  }

  return app.exec();
}
