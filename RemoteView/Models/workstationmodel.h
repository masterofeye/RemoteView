#ifndef WORKSTATIONMODEL_H
#define WORKSTATIONMODEL_H

#include "entitymodel.h"
#include <QModelIndexList>

class WorkstationModel : public Entitymodel
{
    Q_OBJECT
    Q_PROPERTY(RW::WorkstationKind type READ GetType WRITE SetType)
    Q_PROPERTY(QString projectName READ GetProjectName WRITE SetProjectName)


public:
    explicit WorkstationModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    int rowCount(const QModelIndex &parent) const override;
    //QHash<int, QByteArray> roleNames() const override;
    virtual void LoadData() override;

    RW::WorkstationKind GetType(){return m_WorkstationType;}
    void SetType(RW::WorkstationKind Type){m_WorkstationType = Type;}

    QString GetProjectName(){return m_ProjectName;}
    void SetProjectName(QString Name){m_ProjectName = Name;}
private:
    RW::WorkstationKind m_WorkstationType = RW::WorkstationKind::RemoteWorkstation;
    QString m_ProjectName = "";
};

#endif // WORKSTATIONMODEL_H
