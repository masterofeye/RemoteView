#include "Session.h"
#include "RemoteDataConnectLibrary.h"
#include "Ldapwrapper.h"

namespace RW
{
    Session::Session(QObject *parent) : QObject(parent),
        m_User(new RW::SQL::User(this))
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

        RW::SQL::Repository repro(SourceType::SQL,this);
        RW::SQL::Workstation *workstation = new RW::SQL::Workstation();
        if(repro.GetWorkstationByID(m_User->UserWorkstation(),*workstation))
            m_UserWorkstation.append(workstation);

        return m_UserWorkstation;
    }

    bool Session::IsAdminRole(){return m_User->Role() == RW::UserRole::Admin ? true : false;}
    bool Session::IsUserRole(){return m_User->Role() == RW::UserRole::User ? true : false;}
    bool Session::IsCaretakerRole(){return m_User->Role() == RW::UserRole::Caretaker ? true : false;}

    bool Session::AuthenticateUser(QString Username, QString Password)
    {
        RW::SQL::Repository repro(SourceType::SQL,this);
        if(!repro.GetUserByName(Username,*m_User))
        {
            return false;
        }

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
