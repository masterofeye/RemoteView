#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <RemoteCommunicationLibrary.h>

#include <QObject>
#include <QQuickItem>

class QQmlApplicationEngine;
class QQmlContext;

namespace RW{
    namespace SQL
    {
        class Repository;
        class Project;
        class Workstation;
        class SoftwareProject;
    }
}

class Controller : public QObject
{
    Q_OBJECT
private:
    RW::SQL::Repository *m_Repository = nullptr;
    std::shared_ptr<spdlog::logger> m_logger;
    QQmlContext* m_Context = nullptr;

    QList<RW::SQL::Project> *m_ProjectList = nullptr;
    QList<RW::SQL::Workstation> *m_WorkstationList = nullptr;
    QList<RW::SQL::SoftwareProject> *m_SoftwareProjectList = nullptr;

public:
    enum class StartMethode
    {
        Default,
        DualScreen,
        AllScreen
    };
    Q_ENUMS(StartMethode)


    Controller(QObject *parent = 0){};
    explicit Controller(QQmlContext* Context, QObject *parent = 0);
    ~Controller();

    static QQuickItem* FindItemByName(QList<QObject*> nodes, const QString& name);
    static QQuickItem* FindItemByName(QQmlApplicationEngine* engine, const QString& name);

    bool SetupLogEntries();
    bool SetupRemoteWorkstations();

    bool CreateListOfSoftwareProjects();
    bool CreateListOfRemoteWorkstationTypes();

    Q_INVOKABLE QVariant GetFlashEntry(QVariant Workstation,QVariant SoftwareProject);
    Q_INVOKABLE QVariant CreateListOfSoftwareProjectsByProject(QVariant Project);
    Q_INVOKABLE QVariant CreateListOfRemoteWorkstationsByProject(QString ProjectName);
    Q_INVOKABLE QVariant CreateListOfBackendWorkstations();

    Q_INVOKABLE bool FlushDNSCache();
    Q_INVOKABLE bool StartRemoteDesktop(StartMethode RdpStartMethode, QString Hostname);
    Q_INVOKABLE bool WakeUpPC(QString Mac);


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
