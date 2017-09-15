#ifndef UTIL_H
#define UTIL_H

#include <QObject>

QT_BEGIN_NAMESPACE
    class QNetworkAccessManager;
    class QNetworkReply;
QT_END_NAMESPACE

namespace RW {
    namespace CORE {

        class NetworkWrapper : public QObject
        {
            Q_OBJECT
        private:
            QNetworkAccessManager* m_NetAccMan = nullptr;



        public:
            explicit NetworkWrapper(QObject *parent = nullptr);

        signals:

        public slots:
            bool WakeUpPC(QString Mac);
        private slots:
            void OnReplyFinished();

        };
    }
}

#endif // UTIL_H
