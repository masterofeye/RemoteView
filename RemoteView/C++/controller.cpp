#include "Controller.h"
#include "RemoteDataConnectLibrary.h"

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QProcess>

Controller::Controller(QQmlContext* Context,QObject *parent) : QObject(parent),
    m_Context(Context)
{
    m_logger = spdlog::get("sql");
    if (m_logger == nullptr)
        m_logger = spdlog::create<spdlog::sinks::MySqlSink>("sql");

    m_Repository = new RW::SQL::Repository(RW::SourceType::SQL, m_logger);

    m_Context->setContextProperty("Controller", QVariant::fromValue(this));
}

Controller::~Controller()
{
    if(m_ProjectList != nullptr)
        delete m_ProjectList;
    if(m_WorkstationList != nullptr)
        delete m_WorkstationList;
    if(m_Repository != nullptr)
        delete m_Repository;
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
    if(m_Context == nullptr)
        return false;
    QList<RW::SQL::LogEntry> logs;
    if(!m_Repository->GetAllLogEntry(logs))
        return false;

    QList<QObject*>  s;
    for (int i = 0; i < logs.count(); i++)
    {
        s.append(&logs[i]);
    }

    m_Context->setContextProperty("Logs", QVariant::fromValue(s));
    return true;
}
bool Controller::SetupRemoteWorkstations()
{
    if(m_Context == nullptr)
        return false;

    QList<RW::SQL::Workstation> ret;
    if(!m_Repository->GetAllWorkstation(ret))
        return false;

    QList<QObject*>  s;
    for (int i = 0; i < ret.count(); i++)
    {
        RW::SQL::WorkstationType* type = ret[i].TypeOfWorkstation();
        if(type->Type() == RW::WorkstationKind::RemoteWorkstation)
            s.append(&(ret)[i]);
    }
    m_Context->setContextProperty("RemoteWorkstations", QVariant::fromValue(s));
    return true;
}

QVariant Controller::CreateListOfRemoteWorkstationsByProject(QString ProjectName)
{
    if(ProjectName.isEmpty())
        return false;

    if(m_Context == nullptr)
        return false;

    //Wenn schon eine Liste erstellt wurde sollte diese hier zunächst gelöscht werden
    if(m_WorkstationList != nullptr)
        delete m_WorkstationList;

    m_WorkstationList = new QList<RW::SQL::Workstation>();

    if(!m_Repository->GetAllWorkstation(*m_WorkstationList))
        return false;

    QList<QObject*>  s;
    for (int i = 0; i < m_WorkstationList->count(); i++)
    {
        if(m_WorkstationList->at(i).AssignedProject()->Projectname() == ProjectName)
            s.append(&(*m_WorkstationList)[i]);
    }
    m_Context->setContextProperty("RemoteWorkstation", QVariant::fromValue(s));
    return QVariant::fromValue(s);

}

QVariant Controller::CreateListOfBackendWorkstations()
{
    if(m_Context == nullptr)
        return false;

    //Wenn schon eine Liste erstellt wurde sollte diese hier zunächst gelöscht werden
    if(m_WorkstationList != nullptr)
        delete m_WorkstationList;

    m_WorkstationList = new QList<RW::SQL::Workstation>();

    if(!m_Repository->GetAllWorkstation(*m_WorkstationList))
        return false;

    QList<QObject*>  s;
    for (int i = 0; i < m_WorkstationList->count(); i++)
    {
        if(m_WorkstationList->at(i).TypeOfWorkstation()->Type() == RW::WorkstationKind::BackendPC)
            s.append(&(*m_WorkstationList)[i]);
    }
    m_Context->setContextProperty("BackendWorkstation", QVariant::fromValue(s));
    return QVariant::fromValue(s);

}

bool Controller::CreateListOfSoftwareProjects()
{
    if(m_Context == nullptr)
        return false;

    //Wenn schon eine Liste erstellt wurde sollte diese hier zunächst gelöscht werden
    if(m_ProjectList != nullptr)
        delete m_ProjectList;

    m_ProjectList = new QList<RW::SQL::Project> ();

    if(!m_Repository->GetAllProject(*m_ProjectList))
        return false;

    QList<QObject*>  s;
    for (int i = 0; i < m_ProjectList->count(); i++)
    {
        s.append(&(*m_ProjectList)[i]);
    }
    m_Context->setContextProperty("Projects", QVariant::fromValue(s));
    return true;
}

QVariant Controller::GetFlashEntry(QVariant Workstation,QVariant SoftwareProject)
{
    RW::SQL::Workstation* workstation = Workstation.value<RW::SQL::Workstation*>();
    RW::SQL::SoftwareProject* softwareProject = SoftwareProject.value<RW::SQL::SoftwareProject*>();

    QList<RW::SQL::FlashHistory> flash;

    if(!m_Repository->GetLastestFlasHistoryEntryByWorkstationIDAndSoftwareProjectID(workstation->ID().toInt(),
                                                                                    softwareProject->ID().toInt(),
                                                                                    flash))
        return false;

    if(flash.count() > 0)
    {
        QString version = "";
        QString major = flash.first().Major().toString();
        QString minor = flash.first().Minor().toString();
        QString patchlevel = flash.first().PatchLevel().toString();
        QString buildnumber = flash.first().Buildnumber().toString();
        if(!major.isEmpty())
        {
            version += major + ".";
        }

        if(!minor.isEmpty())
        {
            version += minor + ".";
        }

        if(!patchlevel.isEmpty())
        {
            version += patchlevel + ".";
        }

        if(!buildnumber.isEmpty())
        {
            version += buildnumber;
        }
        return version;
    }
    else
        return "NAN";
}

QVariant Controller::CreateListOfSoftwareProjectsByProject(QVariant Project)
{
    if(m_Context == nullptr)
        return QVariant();
    RW::SQL::Project* project = Project.value<RW::SQL::Project*>();
    if(project == nullptr)
        return QVariant();

    //Wenn schon eine Liste erstellt wurde sollte diese hier zunächst gelöscht werden
    if(m_SoftwareProjectList != nullptr)
        delete m_SoftwareProjectList;

    m_SoftwareProjectList = new QList<RW::SQL::SoftwareProject> ();
    if(!m_Repository->GetSoftwareProjectByProjectId(project->ID().toInt(),*m_SoftwareProjectList))
        return QVariant();

    QList<QObject*>  s;
    for (int i = 0; i < m_SoftwareProjectList->count(); i++)
    {
        s.append(&(*m_SoftwareProjectList)[i]);
    }
    //m_Context->setContextProperty("SoftwareProjects", QVariant::fromValue(s));
    return QVariant::fromValue(s);
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
        case StartMethode::Default:
            argList.append("Default.rdp");
            argList.append("/v:"+Hostname );
        break;
        case StartMethode::DualScreen:
            argList.append("DualScreen.rdp");
            argList.append("/v:"+Hostname );
        break;
        case StartMethode::AllScreen:
            argList.append("AllScreen.rdp");
            argList.append("/v:"+Hostname );
        break;
    }
    return rdpProcess->startDetached(programm,argList,qApp->applicationDirPath());
}

/*bool Controller::WakeUpPC(QString Mac)
{
    QString wolURL = "http://pepe.schleissheimer.de/wol.php?mac=";
    

}*/

