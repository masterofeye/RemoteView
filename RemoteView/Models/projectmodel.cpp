#include "projectmodel.h"

ProjectModel::ProjectModel(QObject *parent)
    : Entitymodel(nullptr, parent)
{
    m_Meta = &RW::PERS::Project::staticMetaObject;
    LoadData();
}


QHash<int, QByteArray> ProjectModel::roleNames() const
{
    QHash<int, QByteArray> hashmap = Entitymodel::roleNames();
    hashmap[Qt::UserRole + m_Meta->propertyCount() + 1] = "ProjectObj";
    return hashmap;
}

QVariant ProjectModel::data(const QModelIndex &index, int role) const
{
    if(role != (Qt::UserRole + m_Meta->propertyCount() + 1))
        return Entitymodel::data(index,role);
    if(role == (Qt::UserRole + m_Meta->propertyCount() + 1))
        return QVariant::fromValue<RW::PERS::Project*>(dynamic_cast<RW::PERS::Project*>( m_EntityList.at(index.row())));
    return QVariant();

}


void ProjectModel::LoadData() const {
    RW::PERS::Repository repro(RW::PERS::StrategyType::SQL);

    m_EntityList = repro.Matching(RW::PERS::Criteria::all(&RW::PERS::Project::staticMetaObject));
}
