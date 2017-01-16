#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#include "RemoteDataConnectLibrary.h"
#include "Sessionmanager.h"
#include <spdlog\spdlog.h>
Q_DECLARE_METATYPE( QList<RW::SQL::Project*> )
Q_DECLARE_METATYPE( QList<RW::SQL::RemoteWorkstation*> )
int main(int argc, char *argv[])
{
    RW::SQL::Register::RegisterRWMetaTypes();

    qRegisterMetaType<RW::RemoteWorkstationState>("RW::RemoteWorkstationState");
    qRegisterMetaType<RW::SQL::RemoteWorkstation>("RW::SQL::RemoteWorkstation");
    qRegisterMetaType<RW::SQL::Project>("RW::SQL::Project");
    qRegisterMetaType<RW::SQL::RemoteWorkstation>("RemoteWorkstation");
    qRegisterMetaType<RW::SQL::Project>("Project");
    qmlRegisterType<RW::SQL::RemoteWorkstation>();
    qmlRegisterType<RW::SQL::Project>();
    RW::qmlRegisterMySingleton();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


	RW::SQL::Repository *m_Repository;
	std::shared_ptr<spdlog::logger> m_logger;
	m_logger = spdlog::get("sql");
	if (m_logger == nullptr)
		m_logger = spdlog::create<spdlog::sinks::MySqlSink>("sql");
	m_Repository = new RW::SQL::Repository(RW::SourceType::SQL, m_logger);

	QList<RW::SQL::RemoteWorkstation> ret;
    QList<RW::SQL::Project> projectList;
    m_Repository->GetAllRemoteWorkstation(ret);
    if(!m_Repository->GetAllProject(projectList))
        return 0;
    qDebug() << "Project Anzahl: " << projectList.count();

    QVariant var;
    var.setValue(projectList[0]);
    RW::SQL::Project s2 = var.value<RW::SQL::Project>();
    qDebug() << projectList[1].Projectname();

    qDebug() << ret[0].Hostname();
    QList<QObject*>  s;
    for (int i = 0; i < ret.count(); i++)
    {
        s.append(&ret[i]);
    }

    QList<QObject*> projectListStar;
    for (int i = 0; i < projectList.count(); i++)
    {
        projectListStar.append(&projectList[i]);
    }
    //qDebug() << projectListStar[0]->property("Projectname");
    QQmlContext *ctxt =  engine.rootContext();
    ctxt->setContextProperty("RemoteWorkstations", QVariant::fromValue(s));
    ctxt->setContextProperty("Projects", QVariant::fromValue(projectListStar));

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
