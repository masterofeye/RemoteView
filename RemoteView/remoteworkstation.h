#ifndef REMOTEWORKSTATION_H
#define REMOTEWORKSTATION_H

#include <QObject>

        class RemoteWorkstation : public QObject
        {
            Q_OBJECT

            Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
            Q_PROPERTY(QString color READ color WRITE setColor NOTIFY colorChanged)
            Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
            Q_PROPERTY(QStringList features READ features WRITE setFeatures NOTIFY featuresChanged)

        public:
            RemoteWorkstation(QObject *parent=0);
            RemoteWorkstation(const QString &name, const QString &color, const QString &status, const QStringList &features, QObject *parent=0);

            QString name() const;
            void setName(const QString &name);

            QString color() const;
            void setColor(const QString &color);

            QString status() const;
            void setStatus(const QString &status);

            QStringList features() const;
            void setFeatures(const QStringList &features);

        signals:
            void nameChanged();
            void colorChanged();
            void statusChanged();
            void featuresChanged();

        private:
            QString m_name;
            QString m_status;
            QString m_color;
            QStringList m_features;

        };

#endif // REMOTEWORKSTATION_H
