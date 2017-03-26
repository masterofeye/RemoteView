#include "Controller.h"
#include "RemoteDataConnectLibrary.h"

#include <QQmlApplicationEngine>
#include <QQmlContext>

Controller::Controller(QObject *parent) : QObject(parent)
{
    m_logger = spdlog::get("sql");
    if (m_logger == nullptr)
        m_logger = spdlog::create<spdlog::sinks::MySqlSink>("sql");

    m_Repository = new RW::SQL::Repository(RW::SourceType::SQL, m_logger);
}

QQuickItem* Controller::FindItemByName(QList<QObject*> nodes, const QString& name)
{
    for(int i = 0; i < nodes.size(); i++){
        qDebug() << nodes.at(i)->objectName();
        // search for node
        if (nodes.at(i) && nodes.at(i)->objectName() == name){
            nodes.at(i)->dumpObjectTree();
            return dynamic_cast<QQuickItem*>(nodes.at(i));
        }
        // search in children
        else if (nodes.at(i) && nodes.at(i)->children().size() > 0){
            QQuickItem* item = FindItemByName(nodes.at(i)->children(), name);
            if (item)
                return item;
        }
    }
    // not found
    return NULL;
}


QQuickItem* Controller::FindItemByName(QQmlApplicationEngine* engine, const QString& name)
{
    return FindItemByName(engine->rootObjects(), name);
}


bool Controller::SetupLogEntries(QQmlContext* Context)
{
    if(Context == nullptr)
        return false;
    QList<RW::SQL::LogEntry> *logs = new QList<RW::SQL::RemoteWorkstation>();
    if(!m_Repository->GetAllLogEntry(logs))
        return false;

    QList<QObject*>  s;
    for (int i = 0; i < logs.count(); i++)
    {
        s.append(&logs[i]);
    }

    Context->setContextProperty("Logs", QVariant::fromValue(s));
}
bool Controller::SetupRemoteWorkstations(QQmlContext* Context)
{
    if(Context == nullptr)
        return false;

    QList<RW::SQL::RemoteWorkstation> *ret = new QList<RW::SQL::RemoteWorkstation>();
    if(!m_Repository->GetAllRemoteWorkstation(*ret))
        return false;

    QList<QObject*>  s;
    for (int i = 0; i < ret->count(); i++)
    {
        s.append(&(*ret)[i]);
    }
    Context->setContextProperty("RemoteWorkstations", QVariant::fromValue(s));
}
bool Controller::SetupProjects(QQmlContext* Context)
{
    if(Context == nullptr)
        return false;
    QList<RW::SQL::Project> *projectList = new QList<RW::SQL::Project> ();
    if(!m_Repository->GetAllProject(*projectList))
        return false;

    QList<QObject*>  s;
    for (int i = 0; i < projectList->count(); i++)
    {
        s.append(&(*projectList)[i]);
    }
    Context->setContextProperty("Projects", QVariant::fromValue(s));
}
