#include "NetworkWrapper.h"
#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <qeventloop.h>
#include "MessageWindow.h"
#include <QProcess>
#include <QThread>

namespace RW {
    namespace CORE {
        NetworkWrapper::NetworkWrapper(QObject *parent) : QObject(parent)
        {
        }

        bool NetworkWrapper::WakeUpPC(QString Mac, QString Hostname)
        {
            Worker *worker = new Worker();
            worker->m_Hostname = Hostname;
            worker->m_Mac = Mac;
            QThread* thread = new QThread;
            worker->moveToThread(thread);
            connect(thread, SIGNAL (started()), worker, SLOT (Process()));
            connect(worker, SIGNAL (Finished()), thread, SLOT (quit()));
            connect(worker, SIGNAL (Finished()), worker, SLOT (deleteLater()));
            connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));

            connect(worker, SIGNAL(SuccessfulWakeUp(QString)),this, SIGNAL(SuccessfulWakeUp(QString)));
            connect(worker, SIGNAL(Error(QString)),this,SIGNAL(Error(QString)));


            thread->start();
            return true;
        }
    }
}
