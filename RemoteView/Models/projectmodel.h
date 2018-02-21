#ifndef PROJECTMODEL_H
#define PROJECTMODEL_H

#include "entitymodel.h"

class ProjectModel : public Entitymodel
{
    Q_OBJECT

public:
    explicit ProjectModel(QObject *parent = nullptr);

    //QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;
    virtual void LoadData() override;

private:
};

#endif // PROJECTMODEL_H
