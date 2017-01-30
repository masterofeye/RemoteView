#ifndef SESSIONMANAGER_H
#define SESSIONMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>

namespace RW
{
    class Session;
    class SessionManager : public QObject
    {
        Q_OBJECT
        Q_PROPERTY(RW::Session* ActiveSession READ ActiveSession WRITE setActiveSession NOTIFY ActiveSessionChanged)
    private:
        bool m_Active;
        Session* m_ActiveSession;
    public:
        // delete copy and move constructors and assign operators
        SessionManager(SessionManager const&) = delete;             // Copy construct
        SessionManager(SessionManager&&) = delete;                  // Move construct
        SessionManager& operator=(SessionManager const&) = delete;  // Copy assign
        SessionManager& operator=(SessionManager &&) = delete;      // Move assign

        Q_INVOKABLE bool IsAdminRole();
        Q_INVOKABLE bool IsUserRole();
        Q_INVOKABLE bool IsCaretakerRole();
        Q_INVOKABLE bool AuthenticateUser(QString Username, QString Password);
        Q_INVOKABLE bool IsActive(){return m_Active;}

        bool IsActiveSession(){return m_Active;}
        RW::Session* ActiveSession(){return m_ActiveSession;}

    public:
        SessionManager();
        ~SessionManager();

    private:
        void setActiveSession(Session *ActivesSession){m_ActiveSession = ActivesSession;}

    signals:
        void ActiveSessionChanged();
    public slots:
    };

    static QObject *getMySingleton(QQmlEngine *engine, QJSEngine *scriptEngine)
    {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        return new SessionManager();
    }

    static void qmlRegisterMySingleton()
    {
        qmlRegisterSingletonType<SessionManager>("Rw.SessionManager", 1, 0, "SessionManager", &getMySingleton);
    }

}


#endif // SESSIONMANAGER_H
