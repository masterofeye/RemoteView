#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#include "Controller.h"
#include "RemoteDataConnectLibrary.h"
#include "RemoteCommunicationLibrary.h"
#include "Sessionmanager.h"
#include "Session.h"

int main(int argc, char *argv[])
{
    RW::SQL::Register::RegisterRWMetaTypes();

    qmlRegisterType<RW::COM::Message>("com.mycompany.messaging", 1, 1, "Message");
    qmlRegisterType<Controller>("com.mycompany.controller", 1, 0, "Controller");
    qmlRegisterType<RW::Session>();

    RW::qmlRegisterMySingleton();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //qDebug() << projectListStar[0]->property("Projectname");
    QQmlContext *ctxt =  engine.rootContext();
    Controller* c = new Controller();
    c->SetupLogEntries(ctxt);
    c->SetupProjects(ctxt);
    c->SetupRemoteWorkstations(ctxt);

    ctxt->setContextProperty("Controller", QVariant::fromValue(c));

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));


    return app.exec();
}
