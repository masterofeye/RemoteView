#include "workstationmodel.h"

RW::WorkstationKind kind = RW::WorkstationKind::NON;


WorkstationModel::WorkstationModel(QObject *parent)
    : Entitymodel(parent)
{
    m_Meta = &RW::PERS::Workstation::staticMetaObject;
}



int WorkstationModel::rowCount(const QModelIndex &parent) const
{
    if(!m_IsLoaded)
    {
        LoadData();
        m_IsLoaded = true;
    }
    quint16 amount = 0;
    for(int i=0; i < m_EntityList.size(); i++)
    {
        amount++;
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
            QVariant res = m_Meta->property(id).read(obj);
            return res;
        }
    }
    return QVariant();

}

bool IsMarkedToDelete(const RW::PERS::Entity* o)
{
    const RW::PERS::Workstation* obj = dynamic_cast<const RW::PERS::Workstation*>(o);
    if(kind != obj->TypeOfWorkstation()->Type())
    return true;
    return false;
}

void WorkstationModel::LoadData() const
{
    RW::PERS::Repository repro(RW::PERS::StrategyType::SQL);


    if(m_Project != nullptr)
    {
        std::vector<RW::PERS::Criteria> buffer;
        m_EntityList = repro.Matching(RW::PERS::Criteria::equal(RW::PERS::WorkstationMapper::Project,  QString::number(m_Project->ID().toInt()),&RW::PERS::Workstation::staticMetaObject));
    }
    else
    {
        m_EntityList = repro.Matching(RW::PERS::Criteria::all(&RW::PERS::Workstation::staticMetaObject));

    }

    kind = m_WorkstationType;
    m_EntityList.erase(std::remove_if(m_EntityList.begin(), m_EntityList.end(), IsMarkedToDelete), m_EntityList.end());
}
