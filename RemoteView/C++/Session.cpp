#include "Session.h"
#include "RemoteDataConnectLibrary.h"
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
        //Todo sehr unschön ... wir wissen nicht ob die Source hier stimmt und auch wird kein Logger erzeugt
        RW::SQL::Repository repro(SourceType::SQL,this);
        RW::SQL::User user;
        if(repro.GetUserByName(Username,user))
        {
            qDebug()<< "Einen User gefunden. Name " << user.UserName() << " Password: " << user.Password();

            if(user.Password().compare(Password) == 0)
            {
                *m_User = user;
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            qDebug("Es wurde kein passender User gefunden");
            return false;
        }
        return false;
    }
}
