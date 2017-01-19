#ifndef SESSION_H
#define SESSION_H

#include <QObject>
#include "RemoteDataConnectLibrary.h"
namespace RW
{
    class Session : public QObject
    {
        Q_OBJECT
    private:
        RW::SQL::User* m_User;
    public:
        explicit Session(QObject *parent = 0);
        void AuthenticateUser(QString Password);

        Q_INVOKABLE void IsAdminRole(){m_User->Role() == RW::UserRole::Admin ? true : false;}
        Q_INVOKABLE void IsUserRole(){m_User->Role() == RW::UserRole::User ? true : false;}
        Q_INVOKABLE void IsCaretakerRole(){m_User->Role() == RW::UserRole::Caretaker ? true : false;}
    signals:

    public slots:
    };
}

#endif // SESSION_H
