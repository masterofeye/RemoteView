#include "Sessionmanager.h"
#include "Session.h"

namespace RW
{
    void SessionManager::IsAdminRole()
    {
        return m_ActiveSession->IsAdminRole();
    }

    void SessionManager::IsUserRole()
    {
        return m_ActiveSession->IsUserRole();
    }

    void SessionManager::IsCaretakerRole()
    {
        return m_ActiveSession->IsCaretakerRole();
    }

}
