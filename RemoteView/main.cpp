#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#include "remoteworkstation.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    QList<QObject*> dataList;
    QStringList qList = QStringList() << "iccam" << "bug";
    QStringList qList2 = QStringList() << "iccam" << "bug" << "settings" << "voltage";
    QStringList qList3 = QStringList() << "iccam" << "hudcam" << "bug" << "settings" << "voltage" << "debug";
    QStringList qList4 = QStringList() << "iccam" << "hudcam" << "voltage" << "debug";
    dataList.append(new RemoteWorkstation("A717", "red", "Free", qList));
    dataList.append(new RemoteWorkstation("A843", "green", "Defect",qList2));
    dataList.append(new RemoteWorkstation("A854", "blue", "Free",qList3));
    dataList.append(new RemoteWorkstation("A845", "yellow", "Kunadt",qList4));

    QQmlContext *ctxt =  engine.rootContext();
    ctxt->setContextProperty("myModel", QVariant::fromValue(dataList));
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
