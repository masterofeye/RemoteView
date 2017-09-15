#ifndef LDAPWRAPPER_H
#define LDAPWRAPPER_H

#include <QObject>
#include <windows.h>
#include <winldap.h>


class LDAPWrapper : public QObject
{
    Q_OBJECT
private:
    LDAP* m_LDAPConnection = nullptr;

public:
    explicit LDAPWrapper(QObject *parent = nullptr);

    bool InitializeSession();
    bool ConnectToServer();
    bool BindWithCredentials(QString Username, QString Password);
signals:

public slots:
};

#endif // LDAPWRAPPER_H
