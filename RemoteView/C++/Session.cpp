#include "Session.h"
#include "RemoteDataConnectLibrary.h"
#include "Ldapwrapper.h"

namespace RW
{
    Session::Session(QObject *parent) : QObject(parent),
        m_User(new RW::PERS::User(this))
    {

    }


    Session::Session(const Session&  /*other*/)
    {

    }
    Session& Session::operator=(Session&  /*other*/)
    {
        return *this;
    }

    Session::Session(Session&& /*other*/)
    {


    }

    Session& Session::operator=(Session&&  /*other*/)
    {
        return *this;
    }

    QString Session::UserName()
    {
        return m_User->UserName();
    }

    QList<QObject*> Session::UserWorkstation()
    {
        foreach (auto workstation, m_UserWorkstation) {
            if(workstation != nullptr)
            delete workstation;
        }
        m_UserWorkstation.clear();

        RW::PERS::Repository repro(PERS::StrategyType::SQL);

        m_UserWorkstation.append((PERS::Workstation*) repro.SoleMatching(PERS::Criteria::equal(PERS::WorkstationMapper::WorkstationId, m_User->UserWorkstation(), &PERS::Workstation::staticMetaObject)));

        return m_UserWorkstation;
    }

    bool Session::IsAdminRole(){return m_User->Role() == RW::UserRole::Admin ? true : false;}
    bool Session::IsUserRole(){return m_User->Role() == RW::UserRole::User ? true : false;}
    bool Session::IsCaretakerRole(){return m_User->Role() == RW::UserRole::Caretaker ? true : false;}

    bool Session::AuthenticateUser(QString Username, QString Password)
    {
        RW::PERS::Repository repro(PERS::StrategyType::SQL);

        m_User =(PERS::User*) repro.SoleMatching(PERS::Criteria::equal(PERS::UserMapper::Username, Username, &PERS::User::staticMetaObject));

        LDAPWrapper ldap;
        if(ldap.InitializeSession())
        {
            if(ldap.ConnectToServer())
            {
                if(ldap.BindWithCredentials(Username, Password))
                {
                    return true;
                }
            }
        }
        return false;

    }


}
