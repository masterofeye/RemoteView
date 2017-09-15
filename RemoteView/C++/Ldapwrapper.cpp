#include "Ldapwrapper.h"


#include <Rpc.h>

LDAPWrapper::LDAPWrapper(QObject *parent) : QObject(parent)
{
}


bool LDAPWrapper::InitializeSession()
{
    QString hostName = "hp.schleissheimer.de";

    m_LDAPConnection = ldap_initA(hostName.toLocal8Bit().data(), 389);
    if (m_LDAPConnection == NULL)
    {
        ldap_unbind(m_LDAPConnection);
        return false;
    }
    return true;
}

bool LDAPWrapper::ConnectToServer()
{
    ULONG lRtn = 0;

    lRtn = ldap_connect(m_LDAPConnection, NULL);

    if(lRtn == LDAP_SUCCESS)
        return true;
    else
    {
        ldap_unbind(m_LDAPConnection);
        return false;
    }

}

bool LDAPWrapper::BindWithCredentials(QString Username, QString Password)
{
    QString domain = "CN="+Username+",O=SCHLEISSHEIMER";
    SEC_WINNT_AUTH_IDENTITY secIdent;
    ULONG lRtn = 0;

    QString hostName = "hp.schleissheimer.de";
    QByteArray username8b = Username.toLocal8Bit();
    QByteArray password8b = Password.toLocal8Bit();
    QByteArray hostname8b = hostName.toLocal8Bit();

    secIdent.User = (unsigned short*)username8b.data();
    secIdent.UserLength = username8b.size();
    secIdent.Password =(unsigned short*) password8b.data();
    secIdent.PasswordLength =  password8b.size();
    secIdent.Domain = (unsigned short*)hostname8b.data();
    secIdent.DomainLength =  hostname8b.size();
    secIdent.Flags = SEC_WINNT_AUTH_IDENTITY_ANSI;

const int ldap_version=LDAP_VERSION3;
    ldap_set_option(m_LDAPConnection, LDAP_OPT_PROTOCOL_VERSION, (void *)&ldap_version);
    lRtn = ldap_bind_sA(
                   m_LDAPConnection,     // Session Handle
                   domain.toLocal8Bit().data(),                // Domain DN
                   Password.toLocal8Bit().data(),     // Credential structure
                   LDAP_AUTH_SIMPLE); // Auth mode
       if(lRtn == LDAP_SUCCESS)
       {
            return true;
       }
       else
       {
           ldap_unbind(m_LDAPConnection);
           return false;
       }
}
