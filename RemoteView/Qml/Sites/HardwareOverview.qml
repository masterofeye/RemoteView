import QtQuick 2.9
import QtQuick.Controls 2.2


Item {
    id: root
    width: parent.width
    height: parent.width
    property var project
    property variant workstations : ControllerInstance.CreateListOfRemoteWorkstationsByProject(project.Projectname)
    ListView {
        model:workstations
        anchors.fill: parent
        delegate: HardwareOverviewDelegate {
            hostname: model.modelData.hostname
            project: root.project
            workstation : model.modelData
        }
    }

}
