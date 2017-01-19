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
        Q_PROPERTY(Session* ActiveSession READ ActiveSession WRITE setActiveSession NOTIFY ActiveSessionChanged)
    private:
        bool m_Active;
        Session* m_ActiveSession;
    public:
        Q_INVOKABLE static SessionManager* Instance()
        {
            // Since it's a static variable, if the class has already been created,
            // It won't be created again.
            // And it **is** thread-safe in C++11.

            static SessionManager myInstance;

            // Return a reference to our instance.
            return &myInstance;
        }

        // delete copy and move constructors and assign operators
        SessionManager(SessionManager const&) = delete;             // Copy construct
        SessionManager(SessionManager&&) = delete;                  // Move construct
        SessionManager& operator=(SessionManager const&) = delete;  // Copy assign
        SessionManager& operator=(SessionManager &&) = delete;      // Move assign

        Q_INVOKABLE void IsAdminRole();
        Q_INVOKABLE void IsUserRole();
        Q_INVOKABLE void IsCaretakerRole();

        bool IsActiveSession(){return m_Active;}
        Session* ActiveSession(){return m_ActiveSession;}

    protected:
        SessionManager()
        {
             // Constructor code goes here.
        }

        ~SessionManager()
        {
             // Destructor code goes here.
        }

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

        return SessionManager::Instance();
    }

    static void qmlRegisterMySingleton()
    {
        qmlRegisterSingletonType<SessionManager>("SessionManager", 1, 0, "SessionManager", &getMySingleton);
    }

}


#endif // SESSIONMANAGER_H
