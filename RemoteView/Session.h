#ifndef SESSION_H
#define SESSION_H

#include <QObject>

namespace RW
{
    namespace SQL {
    class User;
    }

    class Session : public QObject
    {
        Q_OBJECT
    private:
        RW::SQL::User* m_User;
    public:
        explicit Session(QObject *parent = 0);
        ~Session(){}
        Session(const Session& other);
        Session& Session::operator=(Session& other);
        Session(Session&& other);
        Session& Session::operator=(Session&& other);

        Q_INVOKABLE bool AuthenticateUser(QString Username, QString Password);

        Q_INVOKABLE bool IsAdminRole();
        Q_INVOKABLE bool IsUserRole();
        Q_INVOKABLE bool IsCaretakerRole();
        Q_INVOKABLE QString UserName();
    signals:

    public slots:
    };
}
Q_DECLARE_METATYPE(RW::Session)
#endif // SESSION_H
