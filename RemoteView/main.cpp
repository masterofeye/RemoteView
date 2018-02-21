#include <QApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include <RemoteDataConnectLibrary.h>
#include <RemoteCommunicationLibrary.h>
#include <qdebug.h>
#include "C++/controller.h"
#include "C++/MessageWindow.h"
#include "C++/Sessionmanager.h"
#include "Models/workstationmodel.h"
#include "Models/projectmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);


    QQmlApplicationEngine engine;

//    qmlRegisterType<RW::PERS::Project>("de.schleissheimer.project", 1, 0, "Project");
//    qmlRegisterType<RW::PERS::User>("de.schleissheimer.user", 1, 0, "User");
//    qRegisterMetaType<RW::PERS::User*>("User*");
//    qRegisterMetaType<RW::WorkstationState>("WorkstationState");
//    qRegisterMetaType<RW::PERS::Project*>("Project*");
//    qRegisterMetaType<RW::PERS::PermanentLoginReason*>("PermanentLoginReason*");
//    qRegisterMetaType<RW::UserRole>("UserRole");
      qRegisterMetaType<RW::WorkstationKind>("WorkstationKind");
//    qRegisterMetaType<RW::PERS::WorkstationType*>("WorkstationType*");
//    qRegisterMetaType<RW::PERS::WorkstationSetting*>("WorkstationSetting*");
//    qmlRegisterType<RW::PERS::Workstation>("de.schleissheimer.workstation", 1, 0, "Workstation");
//      qRegisterMetaType<RW::WorkstationState>();

    qmlRegisterType<Controller>("de.schleissheimer.controller", 1, 0, "Controller");
    qRegisterMetaType<Information>();
    qmlRegisterUncreatableMetaObject(RW::staticMetaObject,"de.schleissheimer.rw",1, 0,"RW","Error: only enums");
    RW::qmlRegisterSessionManager();

    qmlRegisterType<WorkstationModel>("de.schleissheimer.workstationmodel", 1, 0,"WorkstationModel");
    qmlRegisterType<ProjectModel>("de.schleissheimer.projectModel", 1, 0,"ProjectModel");


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
