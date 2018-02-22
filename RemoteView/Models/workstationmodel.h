#ifndef WORKSTATIONMODEL_H
#define WORKSTATIONMODEL_H

#include "entitymodel.h"
#include <QModelIndexList>
#include <QQuickItem>

class WorkstationModel : public Entitymodel
{
    Q_OBJECT
    Q_PROPERTY(RW::WorkstationKind type READ GetType WRITE SetType)
    Q_PROPERTY(RW::PERS::Project* project READ GetProject WRITE SetProject)


public:
    explicit WorkstationModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    int rowCount(const QModelIndex &parent) const override;
    //QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE virtual void LoadData() const override;

    RW::WorkstationKind GetType(){return m_WorkstationType;}
    void SetType(RW::WorkstationKind Type){m_WorkstationType = Type;}

    RW::PERS::Project* GetProject(){return m_Project;}
    void SetProject(RW::PERS::Project* Obj){m_Project = Obj;}


private:
    mutable RW::WorkstationKind m_WorkstationType = RW::WorkstationKind::RemoteWorkstation;
    mutable RW::PERS::Project* m_Project = nullptr;
    mutable bool m_IsLoaded = false;
};

#endif // WORKSTATIONMODEL_H
