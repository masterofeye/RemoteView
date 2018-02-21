#include "workstationmodel.h"

WorkstationModel::WorkstationModel(QObject *parent)
    : Entitymodel(parent)
{
    m_Meta = &RW::PERS::Workstation::staticMetaObject;
     LoadData();
}



int WorkstationModel::rowCount(const QModelIndex &parent) const
{
    quint16 amount = 0;
    for(int i=0; i < m_EntityList.size(); i++)
    {
        const auto &obj = dynamic_cast<RW::PERS::Workstation*>(m_EntityList.at(i));
        if(m_WorkstationType == obj->TypeOfWorkstation()->Type() && m_ProjectName == obj->AssignedProject()->Projectname())
        {
           amount++;
        }
    }
    return amount;
}

QVariant WorkstationModel::data(const QModelIndex &index, int role) const
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

    quint16 id= role-Qt::UserRole;
    if(id>=0)
    {
        for(int j = index.row(); j < m_EntityList.size(); j++)
        {
            const auto &obj = dynamic_cast<RW::PERS::Workstation*>(m_EntityList.at(j));
            if(m_WorkstationType == obj->TypeOfWorkstation()->Type() && m_ProjectName == obj->AssignedProject()->Projectname())
            {

               QVariant res = m_Meta->property(id).read(obj);
               return res;
            }
        }
    }





    return QVariant();

}

void WorkstationModel::LoadData()
{
    RW::PERS::Repository repro(RW::PERS::StrategyType::SQL);

    m_EntityList = repro.Matching(RW::PERS::Criteria::all(&RW::PERS::Workstation::staticMetaObject));

}
