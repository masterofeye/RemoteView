#include "remoteworkstation.h"

    RemoteWorkstation::RemoteWorkstation(QObject *parent)
        : QObject(parent)
    {
    }

    RemoteWorkstation::RemoteWorkstation(const QString &name, const QString &color, const QString &status, const QStringList &features, QObject *parent)
        : QObject(parent), m_name(name), m_color(color), m_status(status), m_features(features)
    {
    }

    QString RemoteWorkstation::name() const
    {
        return m_name;
    }

    void RemoteWorkstation::setName(const QString &name)
    {
        if (name != m_name) {
            m_name = name;
            emit nameChanged();
        }
    }

    QString RemoteWorkstation::color() const
    {
        return m_color;
    }

    void RemoteWorkstation::setColor(const QString &color)
    {
        if (color != m_color) {
            m_color = color;
            emit colorChanged();
        }
    }

    QString RemoteWorkstation::status() const
    {
        return m_status;
    }
    void RemoteWorkstation::setStatus(const QString &status)
    {
        if (status != m_status) {
            m_status = status;
            emit statusChanged();
        }
    }

    QStringList RemoteWorkstation::features() const
    {
        return m_features;
    }

    void RemoteWorkstation::setFeatures(const QStringList &features)
    {
        if (features != m_features) {
            m_features = features;
            emit featuresChanged();
        }
    }
