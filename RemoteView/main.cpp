#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include <RemoteDataConnectLibrary.h>
#include <RemoteCommunicationLibrary.h>
#include <qdebug.h>
#include "C++/controller.h"
#include <QMessageBox>
#include "C++/Sessionmanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;

    qmlRegisterType<RW::SQL::Project>("de.schleissheimer.project", 1, 0, "Project");
    qmlRegisterType<RW::SQL::User>("de.schleissheimer.user", 1, 0, "User");
    qRegisterMetaType<RW::SQL::User*>("User*");
    qRegisterMetaType<RW::WorkstationState>("WorkstationState");
    qRegisterMetaType<RW::SQL::Project*>("Project*");
    qRegisterMetaType<RW::SQL::PermanentLoginReason*>("PermanentLoginReason*");
    qRegisterMetaType<RW::UserRole>("UserRole");
    qRegisterMetaType<RW::WorkstationKind>("WorkstationKind");
    qRegisterMetaType<RW::SQL::WorkstationType*>("WorkstationType*");
    qRegisterMetaType<RW::SQL::WorkstationSetting*>("WorkstationSetting*");
    qmlRegisterType<RW::SQL::Workstation>("de.schleissheimer.workstation", 1, 0, "Workstation");

    qmlRegisterType<Controller>("de.schleissheimer.controller", 1, 0, "Controller");
    //qmlRegisterInterface<RW::WorkstationState>("WorkstationState");
    qRegisterMetaType<RW::WorkstationState>();
    qmlRegisterUncreatableMetaObject(RW::staticMetaObject,"de.schleissheimer.rw",1, 0,"RW","Error: only enums");

    RW::qmlRegisterSessionManager();

    QQmlContext *context =  engine.rootContext();

    Controller c(context);
    //TODO Fehlerbehandlung
    c.CreateListOfRemoteWorkstationTypes();
    c.CreateListOfSoftwareProjects();

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
