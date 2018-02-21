#include "projectmodel.h"

ProjectModel::ProjectModel(QObject *parent)
    : Entitymodel(nullptr, parent)
{
    m_Meta = &RW::PERS::Project::staticMetaObject;
    LoadData();
}


QHash<int, QByteArray> ProjectModel::roleNames() const
{
    return Entitymodel::roleNames();
}
void ProjectModel::LoadData() {
    RW::PERS::Repository repro(RW::PERS::StrategyType::SQL);

    m_EntityList = repro.Matching(RW::PERS::Criteria::all(&RW::PERS::Project::staticMetaObject));
}
