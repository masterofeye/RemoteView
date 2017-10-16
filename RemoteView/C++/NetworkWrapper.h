#ifndef UTIL_H
#define UTIL_H

#include <QObject>
#include <QNetworkReply>
QT_BEGIN_NAMESPACE
    class QNetworkAccessManager;
QT_END_NAMESPACE

/*just for Ping*/
#include <winsock2.h>
#include <iphlpapi.h>
#include <icmpapi.h>
#include <stdio.h>
#pragma comment(lib, "iphlpapi.lib")
#pragma comment(lib, "ws2_32.lib")



enum class Information;

namespace RW {
    namespace CORE {

    class Worker : public QObject
    {
        Q_OBJECT
    private:
        QNetworkAccessManager* m_NetAccMan = nullptr;
    public:
        QString m_Mac ="";
        QString m_Hostname ="";
    public:
        Worker(): m_NetAccMan(new QNetworkAccessManager(this))
        {}


    public slots:

        void Process() {
            connect(m_NetAccMan, SIGNAL(finished(QNetworkReply*)), this, SLOT(OnReplyFinished(QNetworkReply*)));

            QString wolURL = "http://pepe.schleissheimer.de/wol.php?mac=" + m_Mac;
            QNetworkRequest request;
            request.setUrl(QUrl(wolURL));
            request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:55.0) Gecko/20100101 Firefox/55.0");
            m_NetAccMan->get(request);
        }

        void OnReplyFinished(QNetworkReply* Replay)
        {
            if(Replay == nullptr)
                return;

            if(Replay->error())
            {
                //OnError(Replay->error());
                emit Error(m_Hostname);
            }

            QByteArray answer = Replay->readAll();
            QString stringAnswer = QString(answer);
            if(stringAnswer.contains("OK"))
            {
                QStringList parameters;
                parameters << "-n" << "1";
                parameters << m_Hostname;


                if (Ping(m_Hostname)) {
                    emit SuccessfulWakeUp(m_Hostname);
                } else {
                    emit Error(m_Hostname);
                }
            }
            Replay->deleteLater();
            emit Finished();
        }

        bool Ping(QString Hostname)
        {
            HANDLE hIcmpFile;
            DWORD dwRetVal = 0;
            char SendData[32] = "Data Buffer";
            LPVOID ReplyBuffer = NULL;
            DWORD ReplySize = 0;

            struct hostent* record = gethostbyname(Hostname.toStdString().c_str());
            if(record == NULL)
            {
                    return false;
            }
            in_addr * address = (in_addr * )record->h_addr;

            hIcmpFile = IcmpCreateFile();
            if (hIcmpFile == INVALID_HANDLE_VALUE) {
                printf("\tUnable to open handle.\n");
                printf("IcmpCreatefile returned error: %ld\n", GetLastError() );
                return 1;
            }

            ReplySize = sizeof(ICMP_ECHO_REPLY) + sizeof(SendData);
            ReplyBuffer = (VOID*) malloc(ReplySize);
            if (ReplyBuffer == NULL) {
                printf("\tUnable to allocate memory\n");
                return 1;
            }

            int i =0;
            while(i <300){
                dwRetVal = IcmpSendEcho(hIcmpFile, address->S_un.S_addr, SendData, sizeof(SendData),
                    NULL, ReplyBuffer, ReplySize, 200);
                if (dwRetVal != 0) {
                    PICMP_ECHO_REPLY pEchoReply = (PICMP_ECHO_REPLY)ReplyBuffer;
                    struct in_addr ReplyAddr;
                    ReplyAddr.S_un.S_addr = pEchoReply->Address;

                    if(pEchoReply->Status ==IP_SUCCESS)
                        return true;
                }
                i++;
            }
            return false;
        }
    signals:
        void Finished();
        void Error(QString Hostname);
        void SuccessfulWakeUp(QString Hostname);
    };



        class NetworkWrapper : public QObject
        {
            Q_OBJECT
        private:
            QString m_HostName ="";

        public:
            explicit NetworkWrapper(QObject *parent = nullptr);
            bool Ping(QString Hostname);
        signals:
            void Error(QString Hostname);
            void SuccessfulWakeUp(QString Hostname);
        public slots:
            bool WakeUpPC(QString Mac, QString HostName);

        };
    }
}

#endif // UTIL_H
