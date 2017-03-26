#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <RemoteCommunicationLibrary.h>

#include <QObject>
#include <QQuickItem>

class QQmlApplicationEngine;

namespace RW{
    namespace SQL
    {
        class Repository;
    }
}

class Controller : public QObject
{
    Q_OBJECT
private:
    RW::SQL::Repository *m_Repository;
    std::shared_ptr<spdlog::logger> m_logger;
public:
    explicit Controller(QObject *parent = 0);

    static QQuickItem* FindItemByName(QList<QObject*> nodes, const QString& name);
    static QQuickItem* FindItemByName(QQmlApplicationEngine* engine, const QString& name);

    bool SetupLogEntries(QQmlContext* Context);
    bool SetupRemoteWorkstations(QQmlContext* Context);
    bool SetupProjects(QQmlContext* Context);


signals:
    void newMessage(RW::COM::Message Msg);
public slots:
    void onNewMessage(QVariant Msg)
    {
        //Msg.canConvert<>()
        //RW::COM::Message *msg = Msg.value();
        RW::COM::Message *msg = qvariant_cast<RW::COM::Message*>(Msg);
        qDebug() << msg->identifier();
        qDebug() << Msg;
    }
};

#endif // CONTROLLER_H
