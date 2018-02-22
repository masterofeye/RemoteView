#ifndef ENTITYMODEL_H
#define ENTITYMODEL_H

#include <QAbstractItemModel>
#include "RemoteDataConnectLibrary.h"

class Entitymodel : public QAbstractItemModel
{
    Q_OBJECT

public:
    explicit Entitymodel(QObject *parent = nullptr);
    Entitymodel(const QMetaObject* Meta, QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    QModelIndex index(int row, int column,
                      const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex &index) const override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    // Fetch data dynamically:
    bool hasChildren(const QModelIndex &parent = QModelIndex()) const override;

    bool canFetchMore(const QModelIndex &parent) const override;
    void fetchMore(const QModelIndex &parent) override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    // Add data:
    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    // Remove data:
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE virtual void LoadData() const = 0;

protected:
    mutable  std::vector<RW::PERS::Entity*> m_EntityList;
    const QMetaObject* m_Meta;

};

#endif // ENTITYMODEL_H
