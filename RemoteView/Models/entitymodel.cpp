#include "entitymodel.h"

Entitymodel::Entitymodel(QObject *parent): QAbstractItemModel(parent)
{


}

Entitymodel::Entitymodel(const QMetaObject* Meta,QObject *parent)
    : QAbstractItemModel(parent),
      m_Meta(Meta)
{
}

QVariant Entitymodel::headerData(int section, Qt::Orientation orientation, int role) const
{
    Q_UNUSED(orientation)

    if (role != Qt::DisplayRole)
        return QVariant();

    QMetaProperty p = m_Meta->property(section);
    return tr(p.name());
}


QModelIndex Entitymodel::index(int row, int column, const QModelIndex &parent) const
{
    Q_UNUSED(parent)

    return createIndex(row,column, m_EntityList.at(row));
}

QModelIndex Entitymodel::parent(const QModelIndex &index) const
{
    if(index.row() > 0)
        return createIndex(index.row()-1,index.column(), m_EntityList.at(index.row()));
    else
        return QModelIndex();
}

int Entitymodel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_EntityList.size();
}

int Entitymodel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_Meta->propertyCount();
}


bool Entitymodel::hasChildren(const QModelIndex &parent) const
{

    if(parent.row() < m_EntityList.size())
        return true;
    else
        return false;
}

bool Entitymodel::canFetchMore(const QModelIndex &parent) const
{
    qDebug()<< parent.row();
    if(parent.row() < m_EntityList.size())
        return true;
    else
        return false;
}

void Entitymodel::fetchMore(const QModelIndex &parent)
{
    Q_UNUSED(parent);
}

QVariant Entitymodel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if(m_EntityList.size() == 0)
        return QVariant();

    if (role == Qt::DisplayRole) {
            const auto &obj = m_EntityList.at(index.row());
            QMetaProperty p = m_Meta->property(index.column());
            return p.read(obj);
        }

    for(int i=0; i < m_Meta->propertyCount(); i++)
    {
        if(role == Qt::UserRole + i)
        {
            const auto &obj = m_EntityList.at(index.row());
            return m_Meta->property(i).read(obj);
        }
    }

    return QVariant();
}


Qt::ItemFlags Entitymodel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

bool Entitymodel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
    return true;
}

bool Entitymodel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> Entitymodel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int var = 0; var < m_Meta->propertyCount(); ++var) {
        roles[Qt::UserRole+var] = m_Meta->property(var).name();
    }
    return roles;
}


