#include "Sessionmanager.h"
#include "Session.h"

namespace RW
{
    SessionManager::SessionManager(QObject* Parent): QObject(Parent), m_ActiveSession(new Session(this)),
        m_Active(false)
    {

    }

    SessionManager::~SessionManager()
    {

    }

    bool SessionManager::IsAdminRole()
    {
        return m_ActiveSession->IsAdminRole();
    }

    bool SessionManager::IsUserRole()
    {
        return m_ActiveSession->IsUserRole();
    }

    bool SessionManager::IsCaretakerRole()
    {
        return m_ActiveSession->IsCaretakerRole();
    }

    bool SessionManager::AuthenticateUser(QString Username, QString Password)
    {
        return m_Active = m_ActiveSession->AuthenticateUser(Username,Password);
    }

     QList<QObject*> SessionManager::UserWorkstation()
    {
        return m_ActiveSession->UserWorkstation();
    }

}
