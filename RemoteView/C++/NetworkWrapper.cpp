#include "NetworkWrapper.h"
#include <QNetworkReply>
#include <QNetworkAccessManager>

namespace RW {
    namespace CORE {
        NetworkWrapper::NetworkWrapper(QObject *parent) : QObject(parent),
            m_NetAccMan(new QNetworkAccessManager(this))
        {
        }


        bool NetworkWrapper::WakeUpPC(QString Mac)
        {
            QString wolURL = "http://pepe.schleissheimer.de/wol.php?mac=D0:17:C2:97:04:1F";
            QNetworkAccessManager qnam;
            QNetworkReply *replay = qnam.get(QNetworkRequest(wolURL));
            connect(replay, &QNetworkReply::finished, this, &NetworkWrapper::OnReplyFinished);
            connect(replay, static_cast<void(QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
                    [=](QNetworkReply::NetworkError code){ /* ... */ });
            return true;
        }

        void NetworkWrapper::OnReplyFinished()
        {
            QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
            if(reply == nullptr)
                return;

            reply->deleteLater();
        }
    }
}
