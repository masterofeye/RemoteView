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

    bool Session::IsAdminRole(){return m_User->Role() == RW::UserRole::Admin ? true : false;}
    bool Session::IsUserRole(){return m_User->Role() == RW::UserRole::User ? true : false;}
    bool Session::IsCaretakerRole(){return m_User->Role() == RW::UserRole::Caretaker ? true : false;}

    bool Session::AuthenticateUser(QString Username, QString Password)
    {
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
