#include "Controller.h"
#include "RemoteDataConnectLibrary.h"
#include "NetworkWrapper.h"
#include "Sessionmanager.h"
#include "MessageWindow.h"

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QProcess>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QThread>


Controller::Controller(QQmlContext* Context,QObject *parent) : QObject(parent),
    m_Context(Context),
    m_NetWrapper(new RW::CORE::NetworkWrapper(this))
{
    m_logger = spdlog::get("PERS");
    if (m_logger == nullptr)
        m_logger = spdlog::create<spdlog::sinks::MySqlSink>("PERS");

    //m_Repository = new RW::PERS::Repository(RW::SourceType::SQL);

    m_Context->setContextProperty("ControllerInstance", QVariant::fromValue(this));

    m_MessageWindow = new MessageWindow();
    connect(this, &Controller::popMessage, m_MessageWindow, &MessageWindow::Ballon);

    connect(m_NetWrapper, &RW::CORE::NetworkWrapper::Error , this, &Controller::onWOLError);
    connect(m_NetWrapper, &RW::CORE::NetworkWrapper::SuccessfulWakeUp , this, &Controller::onWOLSuccess);
}

Controller::~Controller()
{
    if(m_MessageWindow!=nullptr)
        delete m_MessageWindow;

    if(m_ProjectList != nullptr)
        delete m_ProjectList;
    if(m_WorkstationList != nullptr)
        delete m_WorkstationList;
//    if(m_Repository != nullptr)
//        delete m_Repository;
}
QQuickItem* Controller::FindItemByName(QList<QObject*> nodes, const QString& name)
{
    for(int i = 0; i < nodes.size(); i++){
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

bool Controller::CreateListOfRemoteWorkstationTypes()
{
    if(m_Context == nullptr)
        return false;

    bool res = false;
    QVariantList WorkstationTypeList;


    QMetaEnum metaEnum = QMetaEnum::fromType<RW::WorkstationKind>();
    //Wir müssen hier eins abziehen um nicht auch das non enum zu erwischen
    int count =  metaEnum.keyCount()-1;
    for (int i=0; i < count; ++i)
    {
       WorkstationTypeList.append(metaEnum.valueToKey(i));
    }
    m_Context->setContextProperty("WorkstationKinds", QVariant::fromValue(WorkstationTypeList));


    return res;
}



bool Controller::SetupLogEntries()
{
//    if(m_Context == nullptr)
//        return false;
//    QList<RW::PERS::LogEntry> logs;

//    RW::PERS::Repository repro(RW::PERS::StrategyType);

//    logs.append((PERS::LogEntry*) repro.SoleMatching(PERS::Criteria::equal(RW::PERS::LoggingMapper::ComputerName, , &PERS::Workstation::staticMetaObject)));

//    if(!m_Repository->GetAllLogEntry(logs))
//        return false;

//    QList<QObject*>  s;
//    for (int i = 0; i < logs.count(); i++)
//    {
//        s.append(&logs[i]);
//    }

//    m_Context->setContextProperty("Logs", QVariant::fromValue(s));
    return true;
}
bool Controller::SetupRemoteWorkstations()
{
//    if(m_Context == nullptr)
//        return false;

//    QList<RW::PERS::Workstation> ret;
//    if(!m_Repository->GetAllWorkstation(ret))
//        return false;

//    QList<QObject*>  s;
//    for (int i = 0; i < ret.count(); i++)
//    {
//        RW::PERS::WorkstationType* type = ret[i].TypeOfWorkstation();
//        if(type->Type() == RW::WorkstationKind::RemoteWorkstation)
//            s.append(&(ret)[i]);
//    }
//    m_Context->setContextProperty("RemoteWorkstations", QVariant::fromValue(s));
    return true;
}

QVariant Controller::CreateListOfRemoteWorkstationsByProject(QString ProjectName)
{
//    if(ProjectName.isEmpty())
//        return false;

//    if(m_Context == nullptr)
//        return false;

//    //Wenn schon eine Liste erstellt wurde sollte diese hier zunächst gelöscht werden
//    if(m_WorkstationList != nullptr)
//        delete m_WorkstationList;

//    RW::PERS::Repository repro(RW::PERS::StrategyType::SQL);

//    RW::PERS::Project currentProject = repro.SoleMatching(RW::PERS::Criteria::equal(RW::PERS::ProjectMapper::Name, ProjectName, &RW::PERS::Project::staticMetaObject));

//    m_WorkstationList = new QList<RW::PERS::Workstation*>(repro.Matching(RW::PERS::Criteria::equal(RW::PERS::WorkstationMapper::Project, currentProject.ID(), &RW::PERS::Workstation::staticMetaObject)));

////    QList<QObject*>  s;
////    for (int i = 0; i < m_WorkstationList->count(); i++)
////    {
////        if(m_WorkstationList->at(i).AssignedProject()->Projectname() == ProjectName)
////            s.append(&(*m_WorkstationList)[i]);
////    }
//    m_Context->setContextProperty("RemoteWorkstation", QVariant::fromValue(m_WorkstationList));
return QVariant();

}

QVariant Controller::CreateListOfBackendWorkstations()
{
//    if(m_Context == nullptr)
//        return false;

//    //Wenn schon eine Liste erstellt wurde sollte diese hier zunächst gelöscht werden
//    if(m_WorkstationList != nullptr)
//        delete m_WorkstationList;

//    m_WorkstationList = new QList<RW::PERS::Workstation>();

//    if(!m_Repository->GetAllWorkstation(*m_WorkstationList))
//        return false;

//    QList<QObject*>  s;
//    for (int i = 0; i < m_WorkstationList->count(); i++)
//    {
//        if(m_WorkstationList->at(i).TypeOfWorkstation()->Type() == RW::WorkstationKind::BackendPC)
//            s.append(&(*m_WorkstationList)[i]);
//    }
//    m_Context->setContextProperty("BackendWorkstation", QVariant::fromValue(s));
 return QVariant();

}

bool Controller::CreateListOfSoftwareProjects()
{
//    if(m_Context == nullptr)
//        return false;

//    //Wenn schon eine Liste erstellt wurde sollte diese hier zunächst gelöscht werden
//    if(m_ProjectList != nullptr)
//        delete m_ProjectList;

//    m_ProjectList = new QList<RW::PERS::Project> ();

//    if(!m_Repository->GetAllProject(*m_ProjectList))
//        return false;

//    QList<QObject*>  s;
//    for (int i = 0; i < m_ProjectList->count(); i++)
//    {
//        s.append(&(*m_ProjectList)[i]);
//    }
//    m_Context->setContextProperty("Projects", QVariant::fromValue(s));
    return true;
}

QVariant Controller::GetFlashEntry(QVariant Workstation,QVariant SoftwareProject)
{
//    RW::PERS::Workstation* workstation = Workstation.value<RW::PERS::Workstation*>();
//    RW::PERS::SoftwareProject* softwareProject = SoftwareProject.value<RW::PERS::SoftwareProject*>();

//    QList<RW::PERS::FlashHistory> flash;

//    if(!m_Repository->GetLastestFlasHistoryEntryByWorkstationIDAndSoftwareProjectID(workstation->ID().toInt(),
//                                                                                    softwareProject->ID().toInt(),
//                                                                                    flash))
//        return false;

//    if(flash.count() > 0)
//    {
//        QString version = "";
//        QString major = flash.first().Major().toString();
//        QString minor = flash.first().Minor().toString();
//        QString patchlevel = flash.first().PatchLevel().toString();
//        QString buildnumber = flash.first().Buildnumber().toString();
//        if(!major.isEmpty())
//        {
//            version += major + ".";
//        }

//        if(!minor.isEmpty())
//        {
//            version += minor + ".";
//        }

//        if(!patchlevel.isEmpty())
//        {
//            version += patchlevel + ".";
//        }

//        if(!buildnumber.isEmpty())
//        {
//            version += buildnumber;
//        }
//        return version;
//    }
//    else
        return "NAN";
}

QVariant Controller::CreateListOfSoftwareProjectsByProject(QVariant Project)
{
//    if(m_Context == nullptr)
//        return QVariant();
//    RW::PERS::Project* project = Project.value<RW::PERS::Project*>();
//    if(project == nullptr)
//        return QVariant();

//    //Wenn schon eine Liste erstellt wurde sollte diese hier zunächst gelöscht werden
//    if(m_SoftwareProjectList != nullptr)
//        delete m_SoftwareProjectList;

//    m_SoftwareProjectList = new QList<RW::PERS::SoftwareProject> ();
//    if(!m_Repository->GetSoftwareProjectByProjectId(project->ID().toInt(),*m_SoftwareProjectList))
//        return QVariant();

//    QList<QObject*>  s;
//    for (int i = 0; i < m_SoftwareProjectList->count(); i++)
//    {
//        s.append(&(*m_SoftwareProjectList)[i]);
//    }
//    //m_Context->setContextProperty("SoftwareProjects", QVariant::fromValue(s));
    return QVariant();
}

bool  Controller::FlushDNSCache(){
    BOOL (WINAPI *DoDnsFlushResolverCache)();
    *(FARPROC *)&DoDnsFlushResolverCache = GetProcAddress (LoadLibraryA("dnsapi.dll"), "DnsFlushResolverCache");
    if(!DoDnsFlushResolverCache) return FALSE;
    return DoDnsFlushResolverCache();
}

bool Controller::StartRemoteDesktop(StartMethode RdpStartMethode, QString Hostname)
{
    if(!FlushDNSCache())
        return false;

    QProcess* rdpProcess = new QProcess(this);
    QStringList argList;
    QString programm = "mstsc";
    switch(RdpStartMethode)
    {
        case StartMethode::DEFAULT:
            argList.append("ConnectionFiles//Default.rdp");
            argList.append("/v:"+Hostname );
        break;
        case StartMethode::DUALSCREEN:
            argList.append("ConnectionFiles//DualScreen.rdp");
            argList.append("/v:"+Hostname );
        break;
        case StartMethode::ALLSCREEN:
            argList.append("ConnectionFiles//AllScreen.rdp");
            argList.append("/v:"+Hostname );
        case StartMethode::RGSSCREEN:
            argList.append("ConnectionFiles//AllScreen.rdp");
            argList.append("/v:"+Hostname );
        break;
    }
    return rdpProcess->startDetached(programm,argList,qApp->applicationDirPath());
}

bool Controller::WakeUpPC(QString Mac, QString Hostname)
{
    m_NetWrapper->WakeUpPC(Mac,Hostname);
    return true;
}

void Controller::onWOLError(QString Hostname)
{
    emit popMessage(5000,"The PC wasn't wake up successfuly.", Information::ALERT);
    emit wakeUpFeedback(false, Hostname);
}

void Controller::onWOLSuccess(QString Hostname)
{
    emit popMessage(5000,"The PC was wake up successfuly.", Information::INFO);
    emit wakeUpFeedback(true, Hostname);
}
