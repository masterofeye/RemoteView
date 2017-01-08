#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#include "RemoteDataConnectLibrary.h"
#include <spdlog\spdlog.h>
#include "test.h"

Q_DECLARE_METATYPE( QList<RW::SQL::RemoteWorkstation*> )
int main(int argc, char *argv[])
{
    qRegisterMetaType<RW::SQL::RemoteWorkstation>("RW::SQL::RemoteWorkstation");
    qRegisterMetaType<RW::SQL::RemoteWorkstation>("RemoteWorkstation");
    qmlRegisterType<RW::SQL::RemoteWorkstation>();
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
    m_Repository->GetAllRemoteWorkstation(ret);
	

    QVariant var;
    var.setValue(ret[0]);
    RW::SQL::RemoteWorkstation s2 = var.value<RW::SQL::RemoteWorkstation>();
    qDebug() << s2.hostname();


    QList<QObject*>  s;
    s.append((&s2));
    QQmlContext *ctxt =  engine.rootContext();
    ctxt->setContextProperty("RemoteWorkstations", QVariant::fromValue(s));
	Message msg;
    msg.setAuthor("test");
	engine.rootContext()->setContextProperty("msg", &msg);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
