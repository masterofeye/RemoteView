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
    signals:

    public slots:
    };
}

#endif // SESSION_H
